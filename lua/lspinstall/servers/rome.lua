local config = require'lspconfig'.rome.document_config
require'lspconfig/configs'.rome = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/rome"

return vim.tbl_extend('error', config, {
  install_script = [=[
  [[ ! -f package.json ]] && npm init -y --scope=lspinstall || true
  npm install rome@latest
  ]=]
})
