local config = require'lspconfig'.elixirls.document_config
require'lspconfig/configs'.elixirls = nil -- important, immediately unset the loaded config again

return vim.tbl_extend('error', config, {
  install_script = [[
    curl -fLO https://github.com/elixir-lsp/elixir-ls/releases/latest/download/elixir-ls.zip
    unzip elixir-ls.zip
    chmod +x language_server.sh
    rm -f elixir-ls.zip
  ]],
})
