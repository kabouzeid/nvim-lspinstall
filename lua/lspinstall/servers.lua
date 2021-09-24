local servers = {
  ["angular"] = 'lspinstall/servers/angular',
  ["bash"] = 'lspinstall/servers/bash',
  ["clojure"] = 'lspinstall/servers/clojure',
  ["cmake"] = 'lspinstall/servers/cmake',
  ["cpp"] = 'lspinstall/servers/cpp',
  ["csharp"] = 'lspinstall/servers/csharp',
  ["css"] = 'lspinstall/servers/css',
  ["deno"] = 'lspinstall/servers/deno',
  ["diagnosticls"] = 'lspinstall/servers/diagnosticls',
  ["dockerfile"] = 'lspinstall/servers/dockerfile',
  ["efm"] = 'lspinstall/servers/efm',
  ["elixir"] = 'lspinstall/servers/elixir',
  ["elm"] = 'lspinstall/servers/elm',
  ["ember"] = 'lspinstall/servers/ember',
  ["fortran"] = 'lspinstall/servers/fortran',
  ["go"] = 'lspinstall/servers/go',
  ["graphql"] = 'lspinstall/servers/graphql',
  ["haskell"] = 'lspinstall/servers/haskell',
  ["html"] = 'lspinstall/servers/html',
  ["java"] = 'lspinstall/servers/java',
  ["json"] = 'lspinstall/servers/json',
  ["kotlin"] = 'lspinstall/servers/kotlin',
  ["latex"] = 'lspinstall/servers/latex',
  ["lua"] = 'lspinstall/servers/lua',
  ["php"] = 'lspinstall/servers/php',
  ["puppet"] = 'lspinstall/servers/puppet',
  ["purescript"] = 'lspinstall/servers/purescript',
  ["python"] = 'lspinstall/servers/python',
  ["rome"] = 'lspinstall/servers/rome',
  ["ruby"] = 'lspinstall/servers/ruby',
  ["rust"] = 'lspinstall/servers/rust',
  ["svelte"] = 'lspinstall/servers/svelte',
  ["tailwindcss"] = 'lspinstall/servers/tailwindcss',
  ["terraform"] = 'lspinstall/servers/terraform',
  ["typescript"] = 'lspinstall/servers/typescript',
  ["vim"] = 'lspinstall/servers/vim',
  ["vue"] = 'lspinstall/servers/vue',
  ["yaml"] = 'lspinstall/servers/yaml',
}

return setmetatable({}, {
  __index = function(t, k)
    if not servers[k] then
      return
    end
    local mod = require(servers[k])
    t[k] = mod
    return mod
  end
})
