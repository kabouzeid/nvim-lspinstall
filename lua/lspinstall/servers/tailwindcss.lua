local util = require"lspconfig".util
return {
  install_script = [[
  curl -L -o tailwindcss-intellisense.vsix $(curl -s https://api.github.com/repos/tailwindlabs/tailwindcss-intellisense/releases/latest | grep 'browser_' | cut -d\" -f4)
  unzip -o tailwindcss-intellisense.vsix -d tailwindcss-intellisense
  rm tailwindcss-intellisense.vsix

  echo "#!/usr/bin/env bash" > tailwindcss-intellisense.sh
  echo "node \$(dirname \$0)/tailwindcss-intellisense/extension/dist/server/index.js \$*" >> tailwindcss-intellisense.sh

  chmod +x tailwindcss-intellisense.sh
  ]],
  default_config = {
    cmd = { "node", "./tailwindcss-intellisense/extension/dist/server/index.js", "--stdio" },
    -- filetypes copied and adjusted from tailwindcss-intellisense
    filetypes = {
      -- html
      'aspnetcorerazor',
      'blade',
      'django-html',
      'edge',
      'eelixir', -- vim ft
      'ejs',
      'erb',
      'eruby', -- vim ft
      'gohtml',
      'haml',
      'handlebars',
      'hbs',
      'html',
      -- 'HTML (Eex)',
      -- 'HTML (EEx)',
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
    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb"
      }
    },
    root_dir = function(fname)
      return util.root_pattern('tailwind.config.js', 'tailwind.config.ts')(fname) or
      util.root_pattern('postcss.config.js', 'postcss.config.ts')(fname) or
      util.find_package_json_ancestor(fname) or
      util.find_node_modules_ancestor(fname) or
      util.find_git_ancestor(fname)
      end,
    handlers = {
      -- 1. tailwindcss lang server uses this instead of workspace/configuration
      -- 2. tailwindcss lang server waits for this repsonse before providing hover
      ["tailwindcss/getConfiguration"] = function (err, _, params, client_id, bufnr, _)
        -- params = { _id, languageId? }

        local client = vim.lsp.get_client_by_id(client_id)
        if not client then return end
        if err then error(vim.inspect(err)) end

        local configuration = vim.lsp.util.lookup_section(client.config.settings, "tailwindCSS") or {}
        configuration._id = params._id
        configuration.tabSize = vim.lsp.util.get_effective_tabstop(bufnr) -- used for the CSS preview
        vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", configuration)
      end
    }
  }
}
