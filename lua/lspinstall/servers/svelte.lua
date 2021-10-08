local config = require"lspinstall/util".extract_config("svelte")
config.default_config.cmd[1] = "./node_modules/.bin/svelteserver"

return vim.tbl_extend('error', config, {
  install_script = require"lspinstall/util".get_node_install_script("svelte-language-server@latest")
})
