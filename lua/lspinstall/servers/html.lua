local lsp_util = require"lspinstall/util"

local script_to_use = nil
local cmd_to_use = ""

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  cmd_to_use = { "node", "./vscode-html/html-language-features/server/dist/node/htmlServerMain.js", "--stdio" }
  script_to_use  = [[
  curl -L -o vscode.tar.gz https://update.code.visualstudio.com/latest/linux-x64/stable
  rm -rf vscode
  mkdir vscode
  tar -xzf vscode.tar.gz -C vscode --strip-components 1
  rm vscode.tar.gz

  rm -rf vscode-html
  mkdir vscode-html
  cp -r vscode/resources/app/extensions/node_modules vscode-html
  cp -r vscode/resources/app/extensions/html-language-features vscode-html

  rm -rf vscode
  ]]
end

return {
  install_script = script_to_use,
  default_config = {
    cmd = cmd_to_use ,
    filetypes = {
      -- html
      'aspnetcorerazor',
      'blade',
      'django-html',
      'edge',
      'ejs',
      'eruby',
      'gohtml',
      'haml',
      'handlebars',
      'hbs',
      'html',
      'html-eex',
      'jade',
      'leaf',
      'liquid',
      'markdown',
      'mdx',
      'mustache',
      'njk',
      'nunjucks',
      'php',
      'razor',
      'slim',
      'twig',
      -- mixed
      'vue',
      'svelte',
    },
    root_dir = require'lspconfig'.util.root_pattern(".git", vim.fn.getcwd()),
    init_options = {
      provideFormatter = true,
    },
  }
}
