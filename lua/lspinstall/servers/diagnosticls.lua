local config = require'lspconfig'.diagnosticls.document_config
require'lspconfig/configs'.diagnosticls = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/diagnostic-languageserver"

return vim.tbl_extend('error', config, {
  install_script = [=[
  [[ ! -f package.json ]] && npm init -y --scope=lspinstall || true
  npm install diagnostic-languageserver@latest
  ]=]
})
