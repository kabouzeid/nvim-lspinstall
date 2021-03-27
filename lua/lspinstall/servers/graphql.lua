local config = require"lspconfig".graphql.document_config
require"lspconfig/configs".graphql = nil -- important, unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/graphql-language-service-cli"

require"lspinstall/servers".graphql =
  vim.tbl_extend(
  "error",
  config,
  {
    install_script = [=[
    [[ ! -f package.json ]] && npm init -y --scope=lspinstall || true
    npm install graphql-language-service-cli@latest
    ]=],
    uninstall_script = nil
  }
)
