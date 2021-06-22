local util = require"lspconfig".util
local lsp_util = require"lspinstall/util"

local script_to_use = nil
local cmd_to_use = ""

if lsp_util.is_windows() then
  --TODO somebody implement this if possible for windows
else
  cmd_to_use = { "node", "./tailwindcss-intellisense/extension/dist/server/tailwindServer.js", "--stdio" }
  script_to_use  = [[
  curl -L -o tailwindcss-intellisense.vsix https://github.com/tailwindlabs/tailwindcss-intellisense/releases/download/v0.6.8/vscode-tailwindcss-0.6.8.vsix
  rm -rf tailwindcss-intellisense
  unzip tailwindcss-intellisense.vsix -d tailwindcss-intellisense
  rm tailwindcss-intellisense.vsix

  echo "#!/usr/bin/env bash" > tailwindcss-intellisense.sh
  echo "node \$(dirname \$0)/tailwindcss-intellisense/extension/dist/server/tailwindServer.js \$*" >> tailwindcss-intellisense.sh

  chmod +x tailwindcss-intellisense.sh
  ]]
end

return {
  install_script = script_to_use,
  default_config = {
    cmd = cmd_to_use,
    -- filetypes copied and adjusted from tailwindcss-intellisense
    filetypes = {
      -- html
      'aspnetcorerazor',
      'astro',
      'astro-markdown',
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
        eelixir = 'html-eex',
        eruby = 'erb',
      }
    },
    settings = {
      tailwindCSS = {
        validate = true,
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidScreen = "error",
          invalidVariant = "error",
          invalidConfigPath = "error",
          invalidTailwindDirective = "error",
          recommendedVariantOrder = "warning",
        },
      },
    },
    on_new_config = function(new_config)
      if not new_config.settings then new_config.settings = {} end
      if not new_config.settings.editor then new_config.settings.editor = {} end
      if not new_config.settings.editor.tabSize then
        -- set tab size for hover
        new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
      end
    end,
    root_dir = function(fname)
      return util.root_pattern('tailwind.config.js', 'tailwind.config.ts')(fname) or
      util.root_pattern('postcss.config.js', 'postcss.config.ts')(fname) or
      util.find_package_json_ancestor(fname) or
      util.find_node_modules_ancestor(fname) or
      util.find_git_ancestor(fname)
    end,
  }
}
