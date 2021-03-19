local config = require'lspconfig'.texlab.document_config
require'lspconfig/configs'.texlab = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./texlab"

return vim.tbl_extend('error', config, {
  install_script = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $os in
  linux)
  platform="linux"
  ;;
  darwin)
  platform="macos"
  ;;
  esac

  wget -O texlab.tar.gz $(curl -s https://api.github.com/repos/latex-lsp/texlab/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "$platform")
  tar -xzf texlab.tar.gz
  rm texlab.tar.gz
  ]]
})
