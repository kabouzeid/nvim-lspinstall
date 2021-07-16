local config = require"lspinstall/util".extract_config("puppet")
config.default_config.cmd[1] = "./puppet-editor-services/puppet-languageserver"

return vim.tbl_extend('error', config, {
  install_script = [[
    name=puppet-editor-services
    curl -L -o $name.tar.gz $(curl -s https://api.github.com/repos/puppetlabs/puppet-editor-services/releases/latest | grep -E 'browser_download_url.*tar\.gz"' | cut -d\" -f4)
    rm -rf $name
    mkdir $name
    tar -C $name -zxf $name.tar.gz
    rm $name.tar.gz
  ]]
})
