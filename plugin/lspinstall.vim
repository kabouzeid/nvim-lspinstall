" API

function! lspinstall#install_server(lang)
  call v:lua.require("lspinstall").install_server(a:lang)
endfunction

function! lspinstall#uninstall_server(lang)
  call v:lua.require("lspinstall").uninstall_server(a:lang)
endfunction

function! lspinstall#available_servers() abort
  return luaeval('require("lspinstall").available_servers()')
endfunction

function! lspinstall#installed_servers() abort
  return luaeval('require("lspinstall").installed_servers()')
endfunction

function! lspinstall#is_server_installed(lang) abort
  return luaeval('require("lspinstall").is_server_installed("'.a:lang.'")')
endfunction

" Interface

command! -nargs=1 -complete=custom,s:complete_install LspInstall :call lspinstall#install_server('<args>')
command! -nargs=1 -complete=custom,s:complete_uninstall LspUninstall :call lspinstall#uninstall_server('<args>')

function! s:complete_install(arg, line, pos) abort
  return join(lspinstall#available_servers(), "\n")
endfunction
function! s:complete_uninstall(arg, line, pos) abort
  return join(lspinstall#installed_servers(), "\n")
endfunction
