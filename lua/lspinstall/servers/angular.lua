local config = require'lspconfig'.angularls.document_config
require'lspconfig/configs'.angularls = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/ngserver"

return vim.tbl_extend('error', config, {
  install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install @angular/language-server
  ]]
})
