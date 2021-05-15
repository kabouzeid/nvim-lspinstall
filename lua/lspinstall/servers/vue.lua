local config = require"lspinstall/util".extract_config("vuels")
config.default_config.cmd[1] = "./node_modules/.bin/vls"

return vim.tbl_extend('error', config, {
  install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install vls@latest
  ]]
})
