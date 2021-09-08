local util = require"lspinstall/util"
local config = util.extract_config('r_language_server')
local path = util.install_path('r')

config.default_config.cmd = { 'R', '--slave', '-e', 'library(languageserver, lib.loc = "' .. path .. '"); languageserver::run()' }

local eval_command = '\'install.packages("languageserver", repos = "http://cran.us.r-project.org", lib = "' .. path .. '")\''

return vim.tbl_extend('error', config, {
  install_script = 'R -e ' .. eval_command
})
