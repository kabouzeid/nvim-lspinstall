local config = require"lspinstall/util".extract_config("rust_analyzer")
config.default_config.cmd[1] = "./rust-analyzer"

return vim.tbl_extend('error', config, {
  -- adjusted from https://github.com/mattn/vim-lsp-settings/blob/master/installer/install-rust-analyzer.sh
  install_script = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")
  mchn=$(uname -m | tr "[:upper:]" "[:lower:]")

  if [ $mchn = "arm64" ]; then
    mchn="aarch64"
  fi

  case $os in
    linux)
      libc="musl"
      if [ -z $(ldd /bin/ls | grep 'musl' | head -1 | cut -d ' ' -f1) ]; then
        libc="gnu"
      fi
      platform="unknown-linux-${libc}"
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
})
