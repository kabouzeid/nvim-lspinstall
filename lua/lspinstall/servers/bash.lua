local config = require'lspconfig'.bashls.document_config
require'lspconfig/configs'.bashls = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/bash-language-server"

return vim.tbl_extend('error', config, {
  install_script = [=[
  [[ ! -f package.json ]] && npm init -y --scope=lspinstall || true
  npm install bash-language-server@latest
  ]=]
})
