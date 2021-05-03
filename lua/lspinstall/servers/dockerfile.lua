local config = require"lspinstall/util".extract_config("dockerls")
config.default_config.cmd[1] = "./node_modules/.bin/docker-langserver"

return vim.tbl_extend('error', config, {
  install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install dockerfile-language-server-nodejs@latest
  ]]
})
