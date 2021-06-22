local config = require"lspinstall/util".extract_config("fortls")
local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  config.default_config.cmd[1] = "./venv/bin/fortls"
  script_to_use  = [[
  python3 -m venv ./venv
  ./venv/bin/pip3 install -U pip
  ./venv/bin/pip3 install -U fortran-language-server
  ]]
end


return vim.tbl_extend('error', config, {
  install_script = script_to_use
})
