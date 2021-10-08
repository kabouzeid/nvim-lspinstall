local config = require"lspinstall/util".extract_config("angularls")
config.default_config.cmd[1] = "./node_modules/.bin/ngserver"

return vim.tbl_extend('error', config, {
  install_script = [[

  if command -v yarn 2>/dev/null; then
    # yarn was found
    printf "\nfound yarn\n"
    ! test -f package.json && yarn init -y --scope=lspinstall || true
    yarn add @angular/language-server@latest --ignore-engines
  else
    # yarn was not found
    printf "\ncannot find yarn\n"
    ! test -f package.json && npm init -y --scope=lspinstall || true
    npm install @angular/language-server@latest
  fi

  ]]
})
