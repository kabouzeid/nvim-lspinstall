local config = require"lspinstall/util".extract_config("graphql")
config.default_config.cmd[1] = "./node_modules/.bin/graphql-lsp"

-- specify the path from where to look for the graphql config
config.default_config.on_new_config = function(new_config, new_root_dir)
  local new_cmd = vim.deepcopy(config.default_config.cmd)
  table.insert(new_cmd, '-c')
  table.insert(new_cmd, new_root_dir)
  new_config.cmd = new_cmd
end

return vim.tbl_extend('error', config, {
  install_script = [[

  YARN=/usr/bin/yarn
  NPM=/usr/bin/npm

  Yarn() {
    ! test -f package.json && yarn init -y --scope=lspinstall || true
    yarn add graphql-language-service-cli@latest --ignore-engines
  }

  Npm() {
    ! test -f package.json && npm init -y --scope=lspinstall || true
    npm install graphql-language-service-cli@latest
  }

  if [ ! -x $NPM ] && [ ! -x $YARN ]; then
    # if npm and yarn are not on the system
    printf "\nCan't find npm or yarn on the system\n"
  elif [ -x $NPM ] && [ -x $YARN ]; then
    # if npm and yarn are on the system
    printf "\nFound npm & yarn ... using yarn\n"
    Yarn
  elif [ ! -x $NPM ]; then
    # if npm is not on the system
    printf "\nNpm not found..."
    Yarn
  elif [ ! -x $YARN ]; then
    # if yarn is not on the system
    printf "\nYarn not found..."
    Npm
  fi

  ]]
})
