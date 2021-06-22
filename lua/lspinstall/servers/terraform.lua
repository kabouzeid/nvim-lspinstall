local config = require"lspinstall/util".extract_config("terraformls")
local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  config.default_config.cmd[1] = "./terraform-ls"
  script_to_use  = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")
  arch=$(uname -m | tr "[:upper:]" "[:lower:]")

  case $os in
  linux)
  platform="linux"
  ;;
  darwin)
  platform="darwin"
  ;;
  esac

  case $arch in 
  i386)
  architecture=386
  ;;
  i586)
  architecture=386
  ;;
  i686)
  architecture=386
  ;;
  x86_64)
  architecture=amd64
  ;;
  arm64)
  architecture=arm64
  ;;
  aarch64)
  architecture=arm64
  ;;
  esac

  DOWNLOAD_URL=$(curl -s https://api.github.com/repos/hashicorp/terraform-ls/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "$platform" | grep "$architecture")
  curl -L -o terraform.zip "$DOWNLOAD_URL"
  rm -f terraform-ls
  unzip terraform.zip
  rm terraform.zip
  ]]
end


return vim.tbl_extend('error', config, {
  install_script = script_to_use
})
