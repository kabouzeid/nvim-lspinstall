local config = require"lspinstall/util".extract_config("cmake")
local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  config.default_config.cmd[1] = "./venv/Scripts/cmake-language-server.exe"
  script_to_use = {
    'cmd.exe','/c','python -m venv venv',
    -- '&& .\\venv\\Scripts\\pip.exe install --upgrade pip ', removed,
    '&& .\\venv\\Scripts\\pip.exe install -U cmake-language-server'
  }
else
  config.default_config.cmd[1] = "./venv/bin/cmake-language-server"
  script_to_use = [[
  python3 -m venv ./venv
  ./venv/bin/pip3 install -U pip
  ./venv/bin/pip3 install -U cmake-language-server
  ]]
end

return vim.tbl_extend('error', config, {
  install_script = script_to_use
})
