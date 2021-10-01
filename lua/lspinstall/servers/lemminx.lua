-- 1. get the default config from nvim-lspconfig
local config = require"lspinstall/util".extract_config("lemminx")
-- 2. update the cmd. relative paths are allowed, lspinstall automatically adjusts the cmd and cmd_cwd for us!
config.default_config.cmd[1] = "./lemminx-0.18.0/mvnw"

-- 3. extend the config with an install_script and (optionally) uninstall_script
require'lspinstall/servers'.bash = vim.tbl_extend('error', config, {
  -- lspinstall will automatically create/delete the install directory for every server
  install_script = [[

  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $os in

  darwin)
  curl -fLO https://download.jboss.org/jbosstools/vscode/stable/lemminx-binary/0.18.0-400/lemminx-osx-x86_64.zip
  unzip lemminx-osx-x86_64.zip
  rm -r lemminx-osx-x86_64.zip
  ;;

  linux)
  curl -fLO https://download.jboss.org/jbosstools/vscode/stable/lemminx-binary/0.18.0-400/lemminx-linux.zip
  unzip lemminx-linux.zip
  rm -r lemminx-linux.zip
  ;;

  esac

  ]]
})
