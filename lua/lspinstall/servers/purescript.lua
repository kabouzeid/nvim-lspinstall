local config = require"lspinstall/util".extract_config("purescriptls")
config.default_config.cmd[1] = "./node_modules/.bin/purescript-language-server"

return vim.tbl_extend('error', config, {
  install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install purescript-language-server@latest
  ]]
})
