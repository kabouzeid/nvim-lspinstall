local lsp_util = require"lspinstall/util"

local script_to_use = nil
local cmd_to_use = ""

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  cmd_to_use = { "node", "./vscode-css/css-language-features/server/dist/node/cssServerMain.js", "--stdio" }
  script_to_use  = [[
  curl -o vscode.tar.gz -L https://update.code.visualstudio.com/latest/linux-x64/stable
  rm -rf vscode
  mkdir vscode
  tar -xzf vscode.tar.gz -C vscode --strip-components 1
  rm vscode.tar.gz

  rm -rf vscode-css
  mkdir vscode-css
  cp -r vscode/resources/app/extensions/node_modules vscode-css
  cp -r vscode/resources/app/extensions/css-language-features vscode-css

  rm -rf vscode
  ]]

end

return {
  install_script = script_to_use,
  default_config = {
    cmd = cmd_to_use,
    filetypes = { 'css', 'less', 'scss' },
    root_dir = require'lspconfig'.util.root_pattern(".git", vim.fn.getcwd()),
    init_options = {
      provideFormatter = true,
    },
  }
}
