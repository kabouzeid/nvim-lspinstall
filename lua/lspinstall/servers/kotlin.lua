local config = require "lspinstall/util".extract_config("kotlin_language_server")
local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  config.default_config.cmd[1] = "./server/bin/kotlin-language-server"
  script_to_use  = [[
  curl -fLO https://github.com/fwcd/kotlin-language-server/releases/latest/download/server.zip
  rm -rf server
  unzip server.zip
  rm server.zip
  chmod +x server/bin/kotlin-language-server
  ]]
end


return vim.tbl_extend("error", config, {
  install_script = script_to_use
})
