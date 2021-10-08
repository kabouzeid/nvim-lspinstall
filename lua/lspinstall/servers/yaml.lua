local config = require"lspinstall/util".extract_config("yamlls")
config.default_config.cmd[1] = "./node_modules/.bin/yaml-language-server"

return vim.tbl_extend('error', config, {
  install_script = require"lspinstall/util".get_node_install_script("yaml-language-server@latest")
})
