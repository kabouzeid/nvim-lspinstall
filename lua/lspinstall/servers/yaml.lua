local config = require"lspinstall/util".extract_config("yamlls")
config.default_config.cmd[1] = "./node_modules/.bin/yaml-language-server"

return vim.tbl_extend('error', config, {
  install_script = [[

  if command -v yarn 2>/dev/null; then
    # yarn was found
    printf "\nfound yarn\n"
    ! test -f package.json && yarn init -y  || true
    yarn add yaml-language-server@latest --ignore-engines
  else
    # yarn was not found
    printf "\ncannot find yarn\n"
    ! test -f package.json && npm init -y  || true
    npm install yaml-language-server@latest
  fi

  ]]
})
