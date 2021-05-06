local config = require"lspinstall/util".extract_config("pyright")
config.default_config.cmd[1] = "./node_modules/.bin/elm-language-server"

return vim.tbl_extend('error', config, {
  install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install elm@latest elm-test@latest elm-format@latest @elm-tooling/elm-language-server@latest
  ]]
})
