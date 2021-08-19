local config = require'lspinstall/util'.extract_config('ember')
local lsp_util = require"lspinstall/util"

local script_to_use  = nil

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  config.default_config.cmd[1] = './node_modules/.bin/ember-language-server'
  script_to_use =  [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install @lifeart/ember-language-server@latest
  ]]
end

return vim.tbl_extend('error', config, {
  install_script = script_to_use
})
