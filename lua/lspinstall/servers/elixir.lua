local config = require'lspconfig'.elixirls.document_config
require'lspconfig/configs'.elixirls = nil -- important, immediately unset the loaded config again

return vim.tbl_extend('error', config, {
  install_script = [[
    DOWNLOAD_URL=$(curl -s https://api.github.com/repos/elixir-lsp/elixir-ls/releases/latest | grep 'browser' | grep 'elixir-ls.zip' | cut -d '"' -f4)
    curl -L -o elixir-ls.zip $DOWNLOAD_URL
    unzip elixir-ls.zip
    chmod +x language_server.sh
    rm -f elixir-ls.zip
  ]],
  default_config = {
    cmd = { "./language_server.sh" }
  }
})
