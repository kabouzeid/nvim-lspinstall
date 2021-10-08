local config = require"lspinstall/util".extract_config("tailwindcss")
config.default_config.cmd[1] = "./node_modules/.bin/tailwindcss-language-server"

return vim.tbl_extend('error', config, {
  install_script = require"lspinstall/util".get_node_install_script("@tailwindcss/language-server@latest")
})
