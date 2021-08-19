local config = require"lspinstall/util".extract_config("puppet")
local lsp_util = require"lspinstall/util"

local script_to_use = nil

if lsp_util.is_windows() then
  -- TODO implementation for windows
else
  config.default_config.cmd[1] = "./puppet-editor-services/puppet-languageserver"
  script_to_use = [[
    curl -L -o puppet-editor-services.tar.gz $(curl -s https://api.github.com/repos/puppetlabs/puppet-editor-services/releases/latest | grep -E 'browser_download_url.*tar\.gz"' | cut -d\" -f4)
    rm -rf puppet-editor-services
    mkdir puppet-editor-services
    tar -C puppet-editor-services -zxf puppet-editor-services.tar.gz
    rm puppet-editor-services.tar.gz
  ]]
end

return vim.tbl_extend('error', config, {
  install_script = script_to_use
})
