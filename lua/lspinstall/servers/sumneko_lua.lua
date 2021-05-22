local config = require"lspinstall/util".extract_config("sumneko_lua")
config.default_config.cmd = { "./sumneko-lua-language-server" }

return vim.tbl_extend('error', config, {
  install_script = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $os in
  linux)
  platform="Linux"
  ;;
  darwin)
  platform="macOS"
  ;;
  esac

  curl -L -o sumneko-lua.vsix $(curl -s https://api.github.com/repos/sumneko/vscode-lua/releases/latest | grep 'browser_' | cut -d\" -f4)
  rm -rf sumneko-lua
  unzip sumneko-lua.vsix -d sumneko-lua
  rm sumneko-lua.vsix

  chmod +x sumneko-lua/extension/server/bin/$platform/lua-language-server

  echo "#!/usr/bin/env bash" > sumneko-lua-language-server
  echo "\$(dirname \$0)/sumneko-lua/extension/server/bin/$platform/lua-language-server -E -e LANG=en \$(dirname \$0)/sumneko-lua/extension/server/main.lua \$*" >> sumneko-lua-language-server

  chmod +x sumneko-lua-language-server
  ]]
})
