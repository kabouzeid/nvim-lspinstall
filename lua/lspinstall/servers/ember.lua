local config = require'lspinstall/util'.extract_config('ember')
config.default_config.cmd[1] = './node_modules/.bin/ember-language-server'

return vim.tbl_extend('error', config, {
  install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install @lifeart/ember-language-server@latest
  ]]
})
