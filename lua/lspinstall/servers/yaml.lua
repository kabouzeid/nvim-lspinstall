local config = require'lspconfig'.yamlls.document_config
require'lspconfig/configs'.yamlls = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/yaml-language-server"

return vim.tbl_extend('error', config, {
  install_script = [=[
  [[ ! -f package.json ]] && npm init -y --scope=lspinstall || true
  npm install yaml-language-server@latest
  ]=]
})
