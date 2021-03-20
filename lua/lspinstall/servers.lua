local servers = {
  ["bash"] = require'lspinstall/servers/bash',
  ["cmake"] = require'lspinstall/servers/cmake',
  ["css"] = require'lspinstall/servers/css',
  ["dockerfile"] = require'lspinstall/servers/dockerfile',
  ["go"] = require'lspinstall/servers/go',
  ["html"] = require'lspinstall/servers/html',
  ["json"] = require'lspinstall/servers/json',
  ["latex"] = require'lspinstall/servers/latex',
  ["lua"] = require'lspinstall/servers/lua',
  ["php"] = require'lspinstall/servers/php',
  ["python"] = require'lspinstall/servers/python',
  ["rome"] = require'lspinstall/servers/rome',
  ["ruby"] = require'lspinstall/servers/ruby',
  ["svelte"] = require'lspinstall/servers/svelte',
  ["tailwindcss"] = require'lspinstall/servers/tailwindcss',
  ["typescript"] = require'lspinstall/servers/typescript',
  ["vim"] = require'lspinstall/servers/vim',
  ["vue"] = require'lspinstall/servers/vue',
  ["yaml"] = require'lspinstall/servers/yaml',
}

return servers
