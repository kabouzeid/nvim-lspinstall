-- 1. get the default config from nvim-lspconfig
local config = require"lspinstall/util".extract_config("lemminx")
-- 2. update the cmd. relative paths are allowed, lspinstall automatically adjusts the cmd and cmd_cwd for us!
config.default_config.cmd[1] = "./lemminx-0.18.0/mvnw"

-- 3. extend the config with an install_script and (optionally) uninstall_script
require'lspinstall/servers'.bash = vim.tbl_extend('error', config, {
  -- lspinstall will automatically create/delete the install directory for every server
  install_script = [[

    curl -fLO https://github.com/eclipse/lemminx/archive/refs/tags/0.18.0.tar.gz
    tar xzvf *.tar.gz
    rm *.tar.gz

  ]]
})
