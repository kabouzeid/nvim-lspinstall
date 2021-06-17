-- reference
-- https://github.com/aca/emmet-ls
local config = require"lspinstall/util".extract_config("emmet")
config.default_config.cmd[1] = "./node_modules/.bin/emmet-ls"

return vim.tbl_extend('error', config, {
    install_script = [[
    ! test -f package.json && npm init -y --scope=lspinstall || true
    npm install emmet-ls
    ]]
})
