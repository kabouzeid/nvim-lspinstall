local config = require"lspinstall/util".extract_config("dockerls")
config.default_config.cmd[1] = "./node_modules/.bin/docker-langserver"

return vim.tbl_extend('error', config, {
  install_script = require"lspinstall/util".get_node_install_script("dockerfile-language-server-nodejs@latest")
})
