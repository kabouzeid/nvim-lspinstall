local config = require "lspinstall/util".extract_config("kotlin_language_server")
config.default_config.cmd[1] = "./server/bin/kotlin-language-server"

return vim.tbl_extend("error", config, {
  install_script = [[
    curl -fLO https://github.com/fwcd/kotlin-language-server/releases/latest/download/server.zip
    rm -rf server
    unzip server.zip
    rm server.zip
    chmod +x server/bin/kotlin-language-server
  ]]
})
