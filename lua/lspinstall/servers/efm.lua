local config = require"lspinstall/util".extract_config("efm")
config.default_config.cmd[1] = "./efm-langserver"

return vim.tbl_extend('error', config, {
  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v github.com/mattn/efm-langserver
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
})
