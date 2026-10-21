#!/usr/bin/env python3
"""Keeps each tab's title equal to the title its terminal reports (OSC 0/1/2).

Programs such as Claude Code report the session name that way, but the tab bar
shows the session's own name instead. Runs as an AutoLaunch script.
"""

import asyncio
import os
import signal
import subprocess
import traceback

import iterm2

LOG = os.path.expanduser("~/Library/Logs/sync_tab_title.log")


def log(message):
    with open(LOG, "a") as f:
        f.write(message + "\n")


def terminate_other_instances():
    """Stops older copies of this script: iTerm2 never stops a previous run."""
    listing = subprocess.run(
        ["ps", "-axo", "pid=,command="], capture_output=True, text=True
    ).stdout
    for line in listing.splitlines():
        pid, _, command = line.strip().partition(" ")
        argv = command.split()
        if (
            int(pid) != os.getpid()
            and argv
            and os.path.basename(argv[0]).startswith("python")
            and any(arg.endswith(os.path.basename(__file__)) for arg in argv[1:])
        ):
            os.kill(int(pid), signal.SIGTERM)


async def main(connection):
    terminate_other_instances()
    app = await iterm2.async_get_app(connection)

    async def update_tab(tab):
        session = tab.current_session
        if not session:
            return
        title = await session.async_get_variable("terminalIconName")
        if not title:
            # An empty title gives the tab back its default title.
            await tab.async_set_title("")
            return
        # The title is an interpolated string, so the reported text goes through
        # a user variable, which cannot evaluate anything.
        await tab.async_set_variable("user.title", title)
        await tab.async_set_title("\\(user.title)")

    async def safe_update(tab):
        try:
            await update_tab(tab)
        except Exception:
            log(traceback.format_exc())

    async def watch_session(session_id):
        session = app.get_session_by_id(session_id)
        try:
            async with iterm2.VariableMonitor(
                connection,
                iterm2.VariableScopes.SESSION,
                "terminalIconName",
                session_id,
            ) as mon:
                while True:
                    await mon.async_get()
                    if session.tab:
                        await safe_update(session.tab)
        except Exception:
            log(traceback.format_exc())

    async def watch_focus():
        async with iterm2.FocusMonitor(connection) as monitor:
            while True:
                update = await monitor.async_get_next_update()
                tab = None
                if update.selected_tab_changed:
                    tab = app.get_tab_by_id(update.selected_tab_changed.tab_id)
                elif update.active_session_changed:
                    session = app.get_session_by_id(update.active_session_changed.session_id)
                    tab = session.tab if session else None
                if tab:
                    await safe_update(tab)

    for window in app.terminal_windows:
        for tab in window.tabs:
            await safe_update(tab)
    asyncio.create_task(watch_focus())
    async with iterm2.EachSessionOnceMonitor(app) as mon:
        while True:
            session_id = await mon.async_get()
            asyncio.create_task(watch_session(session_id))


iterm2.run_forever(main)
