local util = require"lspinstall/util"
local config = util.extract_config('rescriptls')
local path = util.install_path('rescript')

config.default_config.cmd = {'node', path .. '/vscode-rescript/extension/server/out/server.js', '--stdio'}

return vim.tbl_extend('error', config, {
  install_script = [[
    curl -s https://api.github.com/repos/rescript-lang/rescript-vscode/releases/latest \
      | grep "browser_download_url.*vsix" \
      | cut -d : -f 2,3 \
      | tr -d '"' \
      | wget -i - -O vscode-rescript.vsix

    unzip -q -o vscode-rescript.vsix -d vscode-rescript
    rm vscode-rescript.vsix
  ]]
})
