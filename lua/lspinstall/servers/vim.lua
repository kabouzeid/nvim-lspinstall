local config = require"lspinstall/util".extract_config("vimls")
config.default_config.cmd[1] = "./node_modules/.bin/vim-language-server"

return vim.tbl_extend('error', config, {
  install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install vim-language-server@latest
  ]]
})
