local config = require'lspconfig'.clangd.document_config
require'lspconfig/configs'.clangd = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./clangd_11.0.0/bin/clangd"

return vim.tbl_extend('error', config, {
  install_script = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $os in
  linux)
  platform="linux"
  ;;
  darwin)
  platform="mac"
  ;;
  esac

  curl -L -o "clangd.zip" "https://github.com/clangd/clangd/releases/download/11.0.0/clangd-$platform-11.0.0.zip"
  unzip clangd.zip
  rm clangd.zip
  ]]
})

