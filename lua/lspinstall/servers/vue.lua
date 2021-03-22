local config = require'lspconfig'.vuels.document_config
require'lspconfig/configs'.vuels = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/vls"

return vim.tbl_extend('error', config, {
  install_script = [=[
  [[ ! -f package.json ]] && npm init -y --scope=lspinstall || true
  npm install vls@latest
  ]=]
})
