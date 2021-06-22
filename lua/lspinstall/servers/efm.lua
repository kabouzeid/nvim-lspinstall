local config = require"lspinstall/util".extract_config("efm")
local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  config.default_config.cmd[1] = "./efm-langserver"
  script_to_use  = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v github.com/mattn/efm-langserver
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]

end

return vim.tbl_extend('error', config, {
  install_script = script_to_use
})
