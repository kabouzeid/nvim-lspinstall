
local config = require"lspinstall/util".extract_config("zls")
config.default_config.cmd[1] = "./ziglang/zls"

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
      windows)
        platform="windows"
        ;;
      *)
        echo "Unsupported platform: $os"
        exit 1
        ;;
      esac

    curl -L -o "zls.tar.xz" $(curl -s https://api.github.com/repos/zigtools/zls/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "x86_64-$platform.tar.xz")
    tar -xvf zls.tar.xz
    mv x86_64-$platform ziglang
    rm zls.tar.xz
    exit 0

  ]]
})
