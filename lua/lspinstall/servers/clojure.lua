local config = require"lspinstall/util".extract_config("clojure_lsp")
config.default_config.cmd[1] = "./clojure-lsp"

return vim.tbl_extend("error", config, {
  install_script = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $os in
  linux)
  platform="linux"
  ;;
  darwin)
  platform="macos"
  ;;
  esac

  curl -L -o "clojure-lsp.zip" $(curl -s https://api.github.com/repos/clojure-lsp/clojure-lsp/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "clojure-lsp-native-${platform}-amd64.zip")
  unzip -o clojure-lsp.zip
  rm clojure-lsp.zip
  chmod +x clojure-lsp
  ]],
})
