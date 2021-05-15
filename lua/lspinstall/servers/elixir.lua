local config = require"lspinstall/util".extract_config("elixirls")
config.default_config.cmd = { "./elixir-ls/language_server.sh" }

return vim.tbl_extend('error', config, {
  install_script = [[
    curl -fLO https://github.com/elixir-lsp/elixir-ls/releases/latest/download/elixir-ls.zip
    rm -rf elixir-ls
    unzip elixir-ls.zip -d elixir-ls
    rm elixir-ls.zip
    chmod +x elixir-ls/language_server.sh
  ]],
})
