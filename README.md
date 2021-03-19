# nvim-lspinstall


## About
This is a very lightweight companion plugin for [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
It adds the missing `:LspInstall <language>` command to conveniently install language servers.
The language servers are installed *locally* into `stdpath("data")`, you can use `:echo stdpath("data")` to find out which directory that is on your machine.


## Installation
Via [Vim-Plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
```

For a very basic setup use something like the following in your lua config.
```lua
require'lspinstall'.setup() -- required, sets require'lspconfig'.[server] for all installed servers

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end
```


## Usage
* `:LspInstall <language>` to install/update the language server for `<language>` (e.g. `:LspInstall python`).
* `:LspUninstall <language>` to uninstall the language server for `<language>`.
* `require'lspinstall/servers'.<server_name> = config` to register an installer; where `config` is any LSP config for [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), with an additional `lspinstall = { install_script = "...", uninstall_script = "..."}` key (see [Custom Installer](#custom-installer) for an example).
* `require'lspinstall'.setup()` to make configs of installed servers in `require'lspinstall/servers'` available in `require'lspconfig'.<server>.setup{}`.


## Advanced Setup (recommended)

A configuration like this automatically reloads the installed servers after installing a language server via `:LspInstall` such that we don't have to restart neovim.

```lua
local function setup_servers()
  require'lspinstall'.setup() -- sets require'lspconfig'.[server] for all installed servers
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{}
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
```


## Bundled Installers

| Language    | Language Server                                                             |
|-------------|-----------------------------------------------------------------------------|
| bash        | bash-language-server                                                        |
| cmake       | cmake-language-server                                                       |
| css         | css-language-features (pulled directly from the latest VSCode release)      |
| dockerfile  | docker-langserver                                                           |
| go          | gopls                                                                       |
| html        | html-language-features (pulled directly from the latest VSCode release)     |
| json        | json-language-features (pulled directly from the latest VSCode release)     |
| latex       | texlab                                                                      |
| lua         | (sumneko) lua-language-server                                               |
| php         | intelephense                                                                |
| python      | pyright-langserver                                                          |
| rome        | rome                                                                        |
| svelte      | svelte-language-server                                                      |
| tailwindcss | tailwindcss-intellisense (pulled directly from the latest VSCode extension) |
| typescript  | typescript-language-server                                                  |
| vim         | vim-language-server                                                         |
| vue         | vls (vetur)                                                                 |
| yaml        | yaml-language-server                                                        |

Note: css, json and html language servers are pulled directly from the latest VSCode release, instead of using the outdated versions provided by e.g. `npm install vscode-html-languageserver-bin`.


## Custom Installer

Several language server installers are built into `nvim-lspinstall` and already registered in `require'lspinstall/servers'` (see `lua/lspinstall/servers/`).
Adding a missing installer is as simple as providing a shell script to install (and optionally uninstall) the language server.

The following example provides an installer for `bash-language-server`.
```lua
-- 1. get the default_config for this server from lspconfig and adjust the cmd path.
--    relative paths are allowed, lspinstall automatically adjusts the cmd and cmd_cwd!
local config = require'lspconfig'.bashls.document_config
require'lspconfig/configs'.bashls = nil -- important, unset the loaded config again
config.default_config.cmd[1] = "./node_modules/.bin/bash-language-server"

-- 2. extend the config with an install and (optionally) uninstall script
require'lspinstall/servers'.bash = vim.tbl_extend('error', config, {
  -- `install` and `uninstall` should install/uninstall the server in the cwd
  -- lspinstall will create an install directory for every server
  install_script = [[
  ! -f package.json && npm init -y --scope=lspinstall || true
  npm install bash-language-server@latest
  ]],
  uninstall_script = nil -- the install directory will be deleted automatically, nothing else todo here
})
```

Do this before you call `require'lspinstall'.setup()`.

## Lua API

* `require'lspinstall'.setup()`

* `require'lspinstall'.installed_servers()`

* `require'lspinstall'.install_server(<lang>)`
* `require'lspinstall'.post_install_hook`

* `require'lspinstall'.uninstall_server(<lang>)`
* `require'lspinstall'.post_uninstall_hook`

`require'lspinstall/servers'`
