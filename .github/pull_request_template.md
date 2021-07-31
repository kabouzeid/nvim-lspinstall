# PLEASE READ BEFORE CREATING THE PR :)

## For new install scripts

You need to create one file, and edit two files. See this PR for a good example: https://github.com/kabouzeid/nvim-lspinstall/pull/106/files

Whenever possible, use `local config = require'lspinstall/util'.extract_config('rust_analyzer')` to extract the config for your language server from [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
If they don't have a config for your language server yet, please create a pull request there first.
Don't worry, they are usually quite fast with merging new configs.
