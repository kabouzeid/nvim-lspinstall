local config = require"lspinstall/util".extract_config("serve_d")
config.default_config.cmd = { "./serve-d" }

return vim.tbl_extend('error', config, {
  -- Install serve-d from https://github.com/Pure-D/serve-d
  install_script = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $os in
  linux)
  platform="linux"
  ;;
  darwin)
  platform="osx"
  ;;
  esac

  curl -L -o serve-d.tar.xz $(curl -s https://api.github.com/repos/Pure-D/serve-d/releases | grep 'browser_' |  cut -d\" -f4 | grep "$platform" | head -1 | grep '.tar.xz')
  tar xf serve-d.tar.xz
  rm -f serve-d.tar.xz
  chmod +x serve-d
  ]]
})
