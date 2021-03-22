local config = require'lspconfig'.intelephense.document_config
require'lspconfig/configs'.intelephense = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/intelephense"

return vim.tbl_extend('error', config, {
  install_script = [=[
  [[ ! -f package.json ]] && npm init -y --scope=lspinstall || true
  npm install intelephense@latest
  ]=]
})
