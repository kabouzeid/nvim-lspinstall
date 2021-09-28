
local config = require"lspinstall/util".extract_config("zls")
config.default_config.cmd[1] = "./zls/zls"

return vim.tbl_extend('error', config, {
  install_script = [[
    os=$(uname -s | tr "[:upper:]" "[:lower:]")

    case $os in
    darwin)
      platform="macos"
    ;;
    linux)
      platform="linux"
    ;;
    esac

    curl -L -o "zls.tar.xz" $(curl -s https://api.github.com/repos/zigtools/zls/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "$platform" | grep "x86_64")
    rm -rf zls
    mkdir zls
    tar -xf zls.tar.xz -C zls --strip-components 1
    rm zls.tar.xz
  ]]
})
