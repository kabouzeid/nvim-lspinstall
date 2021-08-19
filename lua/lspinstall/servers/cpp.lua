local config = require"lspinstall/util".extract_config("clangd")
local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  config.default_config.cmd[1] = "./clangd/bin/clangd.exe"
  script_to_use={
    'cmd.exe','/c',
    [[(for /f "tokens=1,* delims=:" %a in ('curl -s https://api.github.com/repos/clangd/clangd/releases/latest ^| findstr "browser_" ^| findstr "clangd-windows" ') do curl -L -o clangd.zip %b)]],
    "&& ECHO cleaning ",
    "&& del /F /Q clangd ",
    "& tar -xf clangd.zip ",
    "&& del /F /Q clangd.zip ",
    "&& move clangd_* clangd"
  }
else
  config.default_config.cmd[1] = "./clangd/bin/clangd"
  script_to_use=[[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $os in
  linux)
  platform="linux"
  ;;
  darwin)
  platform="mac"
  ;;
  esac

  curl -L -o "clangd.zip" $(curl -s https://api.github.com/repos/clangd/clangd/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "clangd-$platform")
  rm -rf clangd
  unzip clangd.zip
  rm clangd.zip
  mv clangd_* clangd
  ]]
end

return vim.tbl_extend('error', config, {
  install_script = script_to_use
})
