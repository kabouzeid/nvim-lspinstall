local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  script_to_use  = [[
  curl -L -o vscode.tar.gz https://update.code.visualstudio.com/latest/linux-x64/stable
  rm -rf vscode
  mkdir vscode
  tar -xzf vscode.tar.gz -C vscode --strip-components 1
  rm vscode.tar.gz

  rm -rf vscode-json
  mkdir vscode-json
  cp -r vscode/resources/app/extensions/node_modules vscode-json
  cp -r vscode/resources/app/extensions/json-language-features vscode-json

  rm -rf vscode
  ]]
end

return {
  install_script = script_to_use,
  default_config = {
    cmd = { "node", "./vscode-json/json-language-features/server/dist/node/jsonServerMain.js", "--stdio" },
    filetypes = { 'json' },
    root_dir = require'lspconfig'.util.root_pattern(".git", vim.fn.getcwd()),
    init_options = {
      provideFormatter = true,
    },
  }
}
