local config = require"lspinstall/util".extract_config("tailwindcss")
config.default_config.cmd[1] = "./tailwindcss-language-server"

return vim.tbl_extend('error', config, {
  install_script = [[
  curl -L -o tailwindcss-intellisense.vsix $(curl -s https://api.github.com/repos/tailwindlabs/tailwindcss-intellisense/releases/latest | grep 'browser_' | cut -d\" -f4)
  rm -rf tailwindcss-intellisense
  unzip tailwindcss-intellisense.vsix -d tailwindcss-intellisense
  rm tailwindcss-intellisense.vsix

  echo "#!/usr/bin/env bash" > tailwindcss-language-server
  echo "node \$(dirname \$0)/tailwindcss-intellisense/extension/dist/server/tailwindServer.js \$*" >> tailwindcss-language-server

  chmod +x tailwindcss-language-server
  ]],
})
