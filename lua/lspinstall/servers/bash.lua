local config = require"lspinstall/util".extract_config("bashls")
config.default_config.cmd[1] = "./node_modules/.bin/bash-language-server"

return vim.tbl_extend('error', config, {
  install_script = require"lspinstall/util".get_node_install_script("bash-language-server@latest")
})
