local config = require"lspinstall/util".extract_config("diagnosticls")
config.default_config.cmd[1] = "./node_modules/.bin/diagnostic-languageserver"

return vim.tbl_extend('error', config, {
  install_script = require"lspinstall/util".get_node_install_script("diagnostic-languageserver@latest")
})
