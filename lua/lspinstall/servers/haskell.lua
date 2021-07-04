local config = require"lspinstall/util".extract_config("hls")
config.default_config.cmd = { "./hls" }

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

  curl -L -o hls.tar.gz $(curl -s https://api.github.com/repos/haskell/haskell-language-server/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "$platform" | grep '.tar.gz')
  tar -xzf hls.tar.gz
  rm -f hls.tar.gz
  chmod +x haskell-language-server-*

  echo "#!/usr/bin/env bash" > hls
  echo "PATH=\$PATH:$(pwd) $(pwd)/haskell-language-server-wrapper --lsp" >> hls
  chmod +x hls
  ]]
})
