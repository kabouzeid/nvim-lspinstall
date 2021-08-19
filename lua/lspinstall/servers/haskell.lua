local config = require"lspinstall/util".extract_config("hls")
local lsp_util = require"lspinstall/util"

local script_to_use  = nil

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  config.default_config.cmd = { "./hls" }
  script_to_use =  [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $os in
  linux)
  platform="Linux"
  ;;
  darwin)
  platform="macOS"
  ;;
  esac

  curl -L -o hls.tar.gz $(curl -s https://api.github.com/repos/haskell/haskell-language-server/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "$platform" | grep '.tar.gz')
  tar -xzf hls.tar.gz
  rm -f hls.tar.gz
  chmod +x haskell-language-server-*

  echo "#!/usr/bin/env bash" > hls
  echo "PATH=\$PATH:$(pwd) $(pwd)/haskell-language-server-wrapper --lsp" >> hls
  chmod +x hls
  ]]
end

return vim.tbl_extend('error', config, {
  install_script = script_to_use
})
