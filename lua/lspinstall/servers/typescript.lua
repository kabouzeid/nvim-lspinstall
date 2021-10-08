local config = require"lspinstall/util".extract_config("tsserver")
config.default_config.cmd[1] = "./node_modules/.bin/typescript-language-server"

return vim.tbl_extend('error', config, {
  install_script = require"lspinstall/util".get_node_install_script("typescript-language-server@latest typescript@latest")
})
