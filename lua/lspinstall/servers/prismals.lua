local config = require"lspinstall/util".extract_config("prismals")
config.default_config.cmd[1] = "./node_modules/.bin/prisma-language-server"

return vim.tbl_extend('error', config, {
  install_script = require"lspinstall/util".get_node_install_script("@prisma/language-server@latest")
})
