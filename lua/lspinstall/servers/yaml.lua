local config = require"lspinstall/util".extract_config("yamlls")
config.default_config.cmd[1] = "./node_modules/.bin/yaml-language-server"

return vim.tbl_extend('error', config, {
  install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install yaml-language-server@latest
  ]]
})
