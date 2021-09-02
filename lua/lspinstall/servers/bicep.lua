local config = require('lspinstall/util').extract_config('bicep')

return vim.tbl_extend('error', config, {
  install_script = [[
    curl -fLO https://github.com/Azure/bicep/releases/latest/download/bicep-langserver.zip
    unzip bicep-langserver.zip
    rm bicep-langserver.zip
  ]],
})
