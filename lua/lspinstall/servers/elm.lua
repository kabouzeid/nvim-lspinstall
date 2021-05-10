local config = require"lspinstall/util".extract_config("elmls")
config.default_config.cmd[1] = "./node_modules/.bin/elm-language-server"

-- we don't install these globally, their location will be resolved automatically form node_modules
config.default_config.init_options.elmPath = nil
config.default_config.init_options.elmFormatPath = nil
config.default_config.init_options.elmTestPath = nil

return vim.tbl_extend('error', config, {
  install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install elm@latest elm-test@latest elm-format@latest @elm-tooling/elm-language-server@latest
  ]]
})
