#!/usr/bin/env python3
"""Keeps each tab's title equal to the title its terminal reports (OSC 0/1/2).

Programs such as Claude Code report the session name that way, but the tab bar
shows the session's own name instead. It also shows the session variable
`user.status` as the subtitle (see `iterm_status` in shell/functions.sh).
Runs as an AutoLaunch script.
"""

import asyncio
import os
import signal
import subprocess
import traceback

import iterm2

# Statuses that are only worth showing until the user comes back to the tab.
FINISHED_STATUSES = ("🟢 done", "🔴 failed")
# How long a finished status stays when it appears on the tab being looked at.
FINISHED_STATUS_SECONDS = 5

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

    async def show_status_subtitle(session):
        """Shows `user.status` as the subtitle, unless the profile has its own."""
        try:
            profile = await session.async_get_profile()
            if profile.subtitle:
                return
            change = iterm2.LocalWriteOnlyProfile()
            change.set_subtitle("\\(user.status)")
            await session.async_set_profile_properties(change)
        except Exception:
            log(traceback.format_exc())

    async def clear_finished_status(tab):
        session = tab.current_session
        if session and await session.async_get_variable("user.status") in FINISHED_STATUSES:
            await session.async_set_variable("user.status", "")

    app_is_active = True

    def is_focused(session):
        window = app.current_terminal_window
        tab = window.current_tab if window else None
        current = tab.current_session if tab else None
        return app_is_active and current is not None and current.session_id == session.session_id

    async def clear_status_later(session, status):
        try:
            await asyncio.sleep(FINISHED_STATUS_SECONDS)
            # Leaves it when the user left the tab: coming back clears it.
            if (
                is_focused(session)
                and await session.async_get_variable("user.status") == status
            ):
                await session.async_set_variable("user.status", "")
        except Exception:
            log(traceback.format_exc())

    async def watch_status(session_id):
        session = app.get_session_by_id(session_id)
        try:
            async with iterm2.VariableMonitor(
                connection,
                iterm2.VariableScopes.SESSION,
                "user.status",
                session_id,
            ) as mon:
                while True:
                    status = await mon.async_get()
                    if status in FINISHED_STATUSES and session and is_focused(session):
                        asyncio.create_task(clear_status_later(session, status))
        except Exception:
            log(traceback.format_exc())

    async def safe_update(tab, focused=False):
        try:
            await update_tab(tab)
            if focused:
                await clear_finished_status(tab)
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
        nonlocal app_is_active
        async with iterm2.FocusMonitor(connection) as monitor:
            while True:
                update = await monitor.async_get_next_update()
                tab = None
                if update.application_active:
                    app_is_active = update.application_active.application_active
                    window = app.current_terminal_window
                    tab = window.current_tab if app_is_active and window else None
                elif update.selected_tab_changed:
                    tab = app.get_tab_by_id(update.selected_tab_changed.tab_id)
                elif update.active_session_changed:
                    session = app.get_session_by_id(update.active_session_changed.session_id)
                    tab = session.tab if session else None
                elif (
                    update.window_changed
                    and update.window_changed.event
                    == iterm2.FocusUpdateWindowChanged.Reason.TERMINAL_WINDOW_BECAME_KEY
                ):
                    window = app.get_window_by_id(update.window_changed.window_id)
                    tab = window.current_tab if window else None
                if tab:
                    await safe_update(tab, focused=True)

    for window in app.terminal_windows:
        for tab in window.tabs:
            await safe_update(tab)
    asyncio.create_task(watch_focus())
    async with iterm2.EachSessionOnceMonitor(app) as mon:
        while True:
            session_id = await mon.async_get()
            session = app.get_session_by_id(session_id)
            if session:
                await show_status_subtitle(session)
            asyncio.create_task(watch_session(session_id))
            asyncio.create_task(watch_status(session_id))


iterm2.run_forever(main)
