local config = require"lspinstall/util".extract_config("purescriptls")
config.default_config.cmd[1] = "./node_modules/.bin/purescript-language-server"

return vim.tbl_extend('error', config, {
  install_script = require"lspinstall/util".get_node_install_script("purescript-language-server@latest")
})
