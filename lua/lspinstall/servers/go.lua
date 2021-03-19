local config = require'lspconfig'.gopls.document_config
require'lspconfig/configs'.gopls = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./gopls"

return vim.tbl_extend('error', config, {
  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v golang.org/x/tools/gopls@latest
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
})
