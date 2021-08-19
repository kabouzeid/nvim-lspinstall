local config = require"lspinstall/util".extract_config("elmls")
local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  config.default_config.cmd[1] = "./node_modules/.bin/elm-language-server"
  script_to_use  = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install elm@latest elm-test@latest elm-format@latest @elm-tooling/elm-language-server@latest
  ]]
end


-- we don't install these globally, their location will be resolved automatically form node_modules
config.default_config.init_options.elmPath = nil
config.default_config.init_options.elmFormatPath = nil
config.default_config.init_options.elmTestPath = nil

-- elm, elm-test and elm-format are also installed so they can be used instead of the local versions
-- in ./node_modules/.bin/ if needed. e.g. with
-- ```
-- init_options = {
--  elmPath = require'lspinstall/util'.install_path('elm') .. "/node_modules/.bin/elm"
--  elmFormatPath = require'lspinstall/util'.install_path('elm') .. "/node_modules/.bin/elm-format"
--  elmTestPath = require'lspinstall/util'.install_path('elm') .. "/node_modules/.bin/elm-test"
-- }
-- ```
return vim.tbl_extend('error', config, {
  install_script = script_to_use
})
