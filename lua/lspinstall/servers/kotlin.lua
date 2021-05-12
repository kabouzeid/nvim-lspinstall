local config = require "lspinstall/util".extract_config("kotlin_language_server")
config.default_config.cmd[1] = "./kotlin-language-server/bin/kotlin-language-server"

return vim.tbl_extend(
    "error",
    config,
    {
        install_script = [[
  url=$(curl -s https://api.github.com/repos/fwcd/kotlin-language-server/releases/latest | grep browser_ | cut -d\" -f4 | grep server.zip)
  curl -L -o "kotlin.zip" "$url"

  unzip kotlin.zip
  rm kotlin.zip
  mv server kotlin-language-server

  if [ ! -x ./kotlin-language-server/bin/kotlin-language-server ]; then
    chmod +x ./kotlin-language-server/bin/kotlin-language-server
  fi
  ]]
    }
)
