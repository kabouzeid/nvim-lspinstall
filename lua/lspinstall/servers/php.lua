local config = require"lspinstall/util".extract_config("intelephense")
local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
config.default_config.cmd[1] = "./node_modules/.bin/intelephense"
  script_to_use  = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install intelephense@latest
  ]]
end


return vim.tbl_extend('error', config, {
  install_script = script_to_use
})
