local config = require"lspinstall/util".extract_config("angularls")
config.default_config.cmd[1] = "./node_modules/.bin/ngserver"

return vim.tbl_extend('error', config, {
  install_script = [[

  YARN=/usr/bin/yarn
  NPM=/usr/bin/npm

  Yarn() {
    ! test -f package.json && yarn init -y --scope=lspinstall || true
    yarn add @angular/language-server@latest --ignore-engines
  }

  Npm() {
    ! test -f package.json && npm init -y --scope=lspinstall || true
    npm install @angular/language-server
  }

  if [ ! -x "$NPM" ] && [ ! -x "$YARN" ]; then
    # if npm and yarn are not on the system
    printf "\nCan't find npm or yarn on the system\n"
  elif [ -x "$NPM" ] && [ -x "$YARN" ]; then
    # if npm and yarn are on the system
    printf "\nFound npm & yarn ... using yarn\n"
    Yarn
  elif [ ! -x "$NPM" ]; then
    # if npm is not on the system
    printf "\nNpm not found..."
    Yarn
  elif [ ! -x "$YARN" ]; then
    # if yarn is not on the system
    printf "\nYarn not found..."
    Npm
  fi

  ]]
})
