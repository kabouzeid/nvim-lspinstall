local config = require'lspconfig'.clangd.document_config
require'lspconfig/configs'.clangd = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./clangd/bin/clangd"

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

  curl -L -o "clangd.zip" $(curl -s https://api.github.com/repos/clangd/clangd/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "$platform")
  rm -rf clangd
  unzip clangd.zip
  rm clangd.zip
  mv clangd_* clangd
  ]]
})
