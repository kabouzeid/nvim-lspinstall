local config = require'lspconfig'.vimls.document_config
require'lspconfig/configs'.vimls = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/vim-language-server"

return vim.tbl_extend('error', config, {
  install_script = [=[
  [[ ! -f package.json ]] && npm init -y --scope=lspinstall || true
  npm install vim-language-server@latest
  ]=]
})
