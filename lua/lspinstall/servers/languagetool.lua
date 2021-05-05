local config = require"lspinstall/util".extract_config("ltex-ls")
config.default_config.cmd[1] = "./bin/ltex-ls"

return vim.tbl_extend('error', config, {
  install_script = [[
     os=$(uname -s | tr "[:upper:]" "[:lower:]")
      case $os in
      linux)
      platform="Linux"
      ;;
      darwin)
      platform="macOS"
      ;;
    esac
    curl -L -o LanguageTool.tar.gz $(curl -s https://api.github.com/repos/valentjn/ltex-ls/releases/latest | grep 'browser_' | cut -d\" -f4)
    unzip LanguageTool.tar.gz -d LanguageTool
    rm LanguageTool.tar.gz
  ]]
})
