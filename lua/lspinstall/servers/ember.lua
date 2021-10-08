local config = require'lspinstall/util'.extract_config('ember')
config.default_config.cmd[1] = './node_modules/.bin/ember-language-server'

return vim.tbl_extend('error', config, {
  install_script = require"lspinstall/util".get_node_install_script("@lifeart/ember-language-server@latest")
})
