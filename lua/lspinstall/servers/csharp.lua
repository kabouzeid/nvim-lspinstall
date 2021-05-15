local config = require"lspinstall/util".extract_config("omnisharp")
config.default_config.cmd = { "./run", "--languageserver" , "--hostPID", tostring(vim.fn.getpid()) }

return vim.tbl_extend('error', config, {
  install_script = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $os in
  linux)
  platform="linux-x64"
  ;;
  darwin)
  platform="osx"
  ;;
  esac

  curl -L -o "omnisharp.zip" $(curl -s https://api.github.com/repos/OmniSharp/omnisharp-roslyn/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "omnisharp-$platform.zip")
  rm -rf omnisharp
  unzip omnisharp.zip
  rm omnisharp.zip
  chmod +x run
  ]]
})
