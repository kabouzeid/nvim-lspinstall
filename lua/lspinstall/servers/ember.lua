local config = require'lspinstall/util'.extract_config('ember')
config.default_config.cmd[1] = './node_modules/.bin/ember-language-server'

return vim.tbl_extend('error', config, {
  install_script = [[

  if command -v yarn 2>/dev/null; then
    # yarn was found
    printf "\nfound yarn\n"
    ! test -f package.json && yarn init -y --scope=lspinstall || true
    yarn add @lifeart/ember-language-server@latest --ignore-engines
  else
    # yarn was not found
    printf "\ncannot find yarn\n"
    ! test -f package.json && npm init -y --scope=lspinstall || true
    npm install @lifeart/ember-language-server@latest
  fi

  ]]
})
