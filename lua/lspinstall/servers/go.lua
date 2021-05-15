local config = require"lspinstall/util".extract_config("gopls")
config.default_config.cmd[1] = "./gopls"

return vim.tbl_extend('error', config, {
  install_script = [[
  GOPATH=$(pwd) GOBIN=$(pwd) GO111MODULE=on go get -v golang.org/x/tools/gopls
  GOPATH=$(pwd) GO111MODULE=on go clean -modcache
  ]]
})
