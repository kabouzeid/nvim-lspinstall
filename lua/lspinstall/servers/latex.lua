local config = require"lspinstall/util".extract_config("texlab")
local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  config.default_config.cmd[1] = "./texlab"
  script_to_use  = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $os in
  linux)
  platform="linux"
  ;;
  darwin)
  platform="macos"
  ;;
  esac

  curl -L -o texlab.tar.gz $(curl -s https://api.github.com/repos/latex-lsp/texlab/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "$platform")
  tar -xzf texlab.tar.gz
  rm texlab.tar.gz
  ]]
end


return vim.tbl_extend('error', config, {
  install_script = script_to_use
})
