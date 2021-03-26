local config = require'lspconfig'.efm.document_config
require'lspconfig/configs'.efm = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./efm-langserver"

return vim.tbl_extend('error', config, {
  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v github.com/mattn/efm-langserver@HEAD
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
})
