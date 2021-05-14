local config = require"lspinstall/util".extract_config("zls")
config.default_config.cmd[1] = "./zls/zig-out/bin/zls"

return vim.tbl_extend("error", config, {
    install_script = [[
    #!/usr/bin/env bash

    rm -rf zls
    git clone --recurse-submodules https://github.com/zigtools/zls
    cd zls
    zig build -Drelease-safe
    # Generate the zls config enabling all the features
    ./zig-out/bin/zls config
    ]]
})
