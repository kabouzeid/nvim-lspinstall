local config = require"lspinstall/util".extract_config("rust_analyzer")
local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  config.default_config.cmd[1] = "./rust-analyzer"
  script_to_use  = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")
  mchn=$(uname -m | tr "[:upper:]" "[:lower:]")

  if [ $mchn = "arm64" ]; then
    mchn="aarch64"
    fi

    case $os in
    linux)
    platform="unknown-linux-gnu"
    ;;
    darwin)
    platform="apple-darwin"
    ;;
    esac

    curl -L -o "rust-analyzer-$mchn-$platform.gz" "https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-$mchn-$platform.gz"
    gzip -d rust-analyzer-$mchn-$platform.gz

    mv rust-analyzer-$mchn-$platform rust-analyzer

    chmod +x rust-analyzer
    ]]
end


return vim.tbl_extend('error', config, {
  -- adjusted from https://github.com/mattn/vim-lsp-settings/blob/master/installer/install-rust-analyzer.sh
  install_script = script_to_use
  })
