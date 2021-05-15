![logo](/logo.png)

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
The following is a good starting point to integrate with [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
```lua
require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end
```
For a complete example you might refer to my personal configuration in the [Wiki](https://github.com/kabouzeid/nvim-lspinstall/wiki).


## Usage
* `:LspInstall <language>` to install/update the language server for `<language>` (e.g. `:LspInstall python`).
* `:LspUninstall <language>` to uninstall the language server for `<language>`.
* `require'lspinstall'.setup()` to make configs of installed servers available for `require'lspconfig'.<server>.setup{}`.


## Advanced Configuration (recommended)

A configuration like this automatically reloads the installed servers after installing a language server via `:LspInstall` such that we don't have to restart neovim.

```lua
local function setup_servers()
  require'lspinstall'.setup()
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
| angular     | Angular Language Service                                                    |
| bash        | bash-language-server                                                        |
| cmake       | cmake-language-server                                                       |
| cpp         | clangd                                                                      |
| csharp      | OmniSharp                                                                   |
| css         | css-language-features (pulled directly from the latest VSCode release)      |
| dockerfile  | docker-langserver                                                           |
| elixir      | Elixir Language Server (elixir-ls)                                          |
| elm         | Elm Language Server (elm-ls)                                                |
| go          | gopls                                                                       |
| graphql     | GraphQL language service                                                    |
| html        | html-language-features (pulled directly from the latest VSCode release)     |
| java        | Eclipse JDTLS with Lombok                                                   |
| json        | json-language-features (pulled directly from the latest VSCode release)     |
| kotlin      | kotlin-language-server                                                      |
| latex       | texlab                                                                      |
| lua         | (sumneko) lua-language-server                                               |
| php         | intelephense                                                                |
| python      | pyright-langserver                                                          |
| ruby        | solargraph                                                                  |
| rust        | rust-analyzer                                                               |
| svelte      | svelte-language-server                                                      |
| tailwindcss | tailwindcss-intellisense (pulled directly from the latest VSCode extension) |
| terraform   | Terraform Language Server (terraform-ls)                                    |
| typescript  | typescript-language-server                                                  |
| vim         | vim-language-server                                                         |
| vue         | vls (vetur)                                                                 |
| yaml        | yaml-language-server                                                        |

| Name        | Description                                                                 |
|-------------|-----------------------------------------------------------------------------|
| deno        | https://deno.land/                                                          |
| diagnosticls| https://github.com/iamcco/diagnostic-languageserver                         |
| efm         | https://github.com/mattn/efm-langserver                                     |
| rome        | https://rome.tools/                                                         |

Note: css, json and html language servers are pulled directly from the latest VSCode release, instead of using the outdated versions provided by e.g. `npm install vscode-html-languageserver-bin`.


## Custom Installer

Use `require'lspinstall/servers'.<lang> = config` to register a config with an installer.
Here `config` is a LSP config for [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), the only difference is that there are two additional keys `install_script` and `uninstall_script` which contain shell scripts to install/uninstall the language server.

The following example provides an installer for `bash-language-server`.
```lua
-- 1. get the default config from nvim-lspconfig
local config = require"lspinstall/util".extract_config("bashls")
-- 2. update the cmd. relative paths are allowed, lspinstall automatically adjusts the cmd and cmd_cwd for us!
config.default_config.cmd[1] = "./node_modules/.bin/bash-language-server"

-- 3. extend the config with an install_script and (optionally) uninstall_script
require'lspinstall/servers'.bash = vim.tbl_extend('error', config, {
  -- lspinstall will automatically create/delete the install directory for every server
  install_script = [[
  ! test -f package.json && npm init -y --scope=lspinstall || true
  npm install bash-language-server@latest
  ]],
  uninstall_script = nil -- can be omitted
})
```

Make sure to do this before you call `require'lspinstall'.setup()`.

Note: **don't** replace the `/` with a `.` in the `require` calls above ([see here if you're interested why](https://github.com/kabouzeid/nvim-lspinstall/issues/14)).


## Lua API

* `require'lspinstall'.setup()`

* `require'lspinstall'.installed_servers()`

* `require'lspinstall'.install_server(<lang>)`
* `require'lspinstall'.post_install_hook`

* `require'lspinstall'.uninstall_server(<lang>)`
* `require'lspinstall'.post_uninstall_hook`

* `require'lspinstall/servers'`

* `require'lspinstall/util'.extract_config(<lspconfig-name>)`
