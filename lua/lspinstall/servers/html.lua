return {
  install_script = [[
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
  ]],
  default_config = {
    cmd = { "node", "./vscode-html/html-language-features/server/dist/node/htmlServerMain.js", "--stdio" },
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
