# Installs Erlang through asdf with the build options kerl needs on macOS.
#
# Usage: `asdf-install-erlang 26.2.2`
asdf-install-erlang() {
  KERL_CONFIGURE_OPTIONS="--disable-debug --disable-silent-rules --disable-jit --without-javac --without-odbc --enable-shared-zlib --enable-dynamic-ssl-lib --enable-hipe --enable-smp-support --enable-threads --enable-kernel-poll --enable-wx --with-wx-config=$(which wx-config) --enable-darwin-64bit --with-ssl=$(brew --prefix openssl)" \
    asdf install erlang "$@"
}
