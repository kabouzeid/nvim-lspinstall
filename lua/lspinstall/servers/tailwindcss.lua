return {
  install_script = [[
  wget -O tailwindcss-intellisense.vsix $(curl -s https://api.github.com/repos/tailwindlabs/tailwindcss-intellisense/releases/latest | grep 'browser_' | cut -d\" -f4)
  unzip -o tailwindcss-intellisense.vsix -d tailwindcss-intellisense
  rm tailwindcss-intellisense.vsix

  echo "#!/usr/bin/env bash" > tailwindcss-intellisense.sh
  echo "node \$(dirname \$0)/tailwindcss-intellisense/extension/dist/server/index.js \$*" >> tailwindcss-intellisense.sh

  chmod +x tailwindcss-intellisense.sh
  ]],
  default_config = {
    cmd = { "node", "./tailwindcss-intellisense/extension/dist/server/index.js", "--stdio" },
    filetypes = {
      -- html
      'aspnetcorerazor',
      'blade',
      'django-html',
      'edge',
      'ejs',
      'erb',
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
      -- css
      'css',
      'less',
      'postcss',
      'sass',
      'scss',
      'stylus',
      'sugarss',
      -- js
      'javascript',
      'javascriptreact',
      'reason',
      'rescript',
      'typescript',
      'typescriptreact',
      -- mixed
      'vue',
      'svelte',
    },
    root_dir = require"lspconfig".util.find_git_ancestor,
    handlers = {
      ["tailwindcss/getConfiguration"] = function (_, _, params, _, bufnr, _)
        -- tailwindcss lang server waits for this repsonse before providing hover
        vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
      end
    }
  }
}
