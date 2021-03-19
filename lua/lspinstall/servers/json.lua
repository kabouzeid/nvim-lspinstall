return {
  install_script = [[
  wget -O vscode.tar.gz https://update.code.visualstudio.com/latest/linux-x64/stable
  rm -rf vscode
  mkdir vscode
  tar -xzf vscode.tar.gz -C vscode --strip-components 1
  rm vscode.tar.gz

  rm -rf vscode-json
  mkdir vscode-json
  cp -r vscode/resources/app/extensions/node_modules vscode-json
  cp -r vscode/resources/app/extensions/json-language-features vscode-json

  rm -rf vscode
  ]],
  default_config = {
    cmd = { "node", "./vscode-json/json-language-features/server/dist/node/jsonServerMain.js", "--stdio" },
    filetypes = { 'json' },
    root_dir = require'lspconfig'.util.root_pattern(".git", vim.fn.getcwd()),
    init_options = {
      provideFormatter = true,
    },
  }
}
