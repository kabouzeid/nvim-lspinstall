local config = require'lspconfig'.dockerls.document_config
require'lspconfig/configs'.dockerls = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/docker-langserver"

return vim.tbl_extend('error', config, {
  install_script = [=[
  [[ ! -f package.json ]] && npm init -y --scope=lspinstall || true
  npm install dockerfile-language-server-nodejs@latest
  ]=]
})
