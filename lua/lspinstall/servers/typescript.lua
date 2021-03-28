local config = require'lspconfig'.tsserver.document_config
require'lspconfig/configs'.tsserver = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/typescript-language-server"

return vim.tbl_extend('error', config, {
  install_script = [=[
  [[ ! -f package.json ]] && npm init -y --scope=lspinstall || true
  npm install typescript-language-server@latest typescript@latest
  ]=]
})
