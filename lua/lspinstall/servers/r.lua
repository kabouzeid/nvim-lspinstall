local config = require'lspinstall/util'.extract_config('r_language_server')

return vim.tbl_extend('error', config, {
  install_script = [[
    R -e 'install.packages("languageserver", repos="http://cran.us.r-project.org")'
  ]]
})
