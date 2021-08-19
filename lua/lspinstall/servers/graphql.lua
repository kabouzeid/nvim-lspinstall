local config = require"lspinstall/util".extract_config("graphql")
local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  config.default_config.cmd[1] = "./node_modules/.bin/graphql-lsp"
  script_to_use  = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install graphql-language-service-cli@latest
  ]]
end


-- specify the path from where to look for the graphql config
config.default_config.on_new_config = function(new_config, new_root_dir)
  local new_cmd = vim.deepcopy(config.default_config.cmd)
  table.insert(new_cmd, '-c')
  table.insert(new_cmd, new_root_dir)
  new_config.cmd = new_cmd
end

return vim.tbl_extend('error', config, {
  install_script = script_to_use
})
