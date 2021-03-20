local config = require'lspconfig'.solargraph.document_config
require'lspconfig/configs'.solargraph = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./solargraph/solargraph"

return vim.tbl_extend('error', config, {
  -- adjusted from https://github.com/mattn/vim-lsp-settings/blob/master/installer/install-solargraph.sh
  install_script = [[
  wget -O solargraph.tar $(curl -s https://api.github.com/repos/castwide/solargraph/tags | grep 'tarball_url' | cut -d\" -f4 | head -n1)
  rm -rf solargraph
  mkdir solargraph
  tar -xzf solargraph.tar -C solargraph --strip-components 1
  rm solargraph.tar
  cd solargraph

  bundle install --without development --path vendor/bundle

  echo '#!/usr/bin/env bash' > solargraph
  echo 'cd "$(dirname "$0")" || exit' >> solargraph
  echo 'bundle exec solargraph $*' >> solargraph

  chmod +x solargraph
  ]]
})
