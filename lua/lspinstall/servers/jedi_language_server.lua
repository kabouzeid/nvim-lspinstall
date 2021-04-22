local config = require'lspconfig'.jedi_language_server.document_config
require'lspconfig/configs'.jedi_language_server = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./venv/bin/jedi-language-server"

return vim.tbl_extend('error', config, {
  install_script = [[
  python3 -m venv ./venv
  ./venv/bin/pip3 install --upgrade pip
  ./venv/bin/pip3 install --upgrade jedi-language-server
  ]]
})
