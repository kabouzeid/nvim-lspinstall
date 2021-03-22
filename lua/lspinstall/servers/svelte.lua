local config = require'lspconfig'.svelte.document_config
require'lspconfig/configs'.svelte = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/svelteserver"

return vim.tbl_extend('error', config, {
  install_script = [=[
  [[ ! -f package.json ]] && npm init -y --scope=lspinstall || true
  npm install svelte-language-server@latest
  ]=]
})
