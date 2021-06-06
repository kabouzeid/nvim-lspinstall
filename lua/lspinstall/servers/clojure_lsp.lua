local config = require"lspinstall/util".extract_config("clojure_lsp")
if 1 == vim.fn.executable("brew") then
  config.default_config.cmd[1] = "clojure-lsp"
  return vim.tbl_extend('error', config, {
    install_script = [[
    echo "Installing homebrew version"
    if brew ls --versions clojure-lsp-native >/dev/null; then
        brew upgrade clojure-lsp-native
    else
        brew install clojure-lsp-native
    fi
    ]],
    uninstall_script = [[
    echo "Uninstalling homebrew version"
    if brew ls --versions clojure-lsp-native >/dev/null; then
        brew uninstall clojure-lsp-native
    fi
    ]]
  })
else
  config.default_config.cmd[1] = "./clojure-lsp"
  return vim.tbl_extend('error', config, {
    install_script = [[
    version="2021.06.01-16.19.44"
    echo "Installing version: ${version}"
    os=$(uname -s | tr "[:upper:]" "[:lower:]")
    case $os in
    linux)
    platform="linux"
    ;;
    darwin)
    platform="macos"
    ;;
    esac
    curl -L -o clojure-lsp.zip "https://github.com/clojure-lsp/clojure-lsp/releases/download/${version}/clojure-lsp-native-${platform}-amd64.zip"
    unzip -o clojure-lsp.zip
    rm clojure-lsp.zip
    chmod +x clojure-lsp
    ]]
  })
end
