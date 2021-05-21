local M = {}

--- Gets a copy of the config that would be used by lspconfig. Without side effects.
--@returns a fresh config
function M.extract_config(name)
  -- needed so we can restore the initial state at the end
  local was_config_set = require'lspconfig/configs'[name]
  local was_package_loaded = package.loaded['lspconfig/' .. name]

  -- gets or requires config
  local config = require'lspconfig'[name].document_config

  -- restore the initial state
  if not was_config_set then
    require'lspconfig/configs'[name] = nil
  end
  if not was_package_loaded then
    package.loaded['lspconfig/' .. name] = nil
  end

  return vim.deepcopy(config)
end

--- Gets lsp server install directory
--@returns string
function M.install_path(lang)
  return vim.fn.stdpath("data") .. "/lspinstall/" .. lang
end

--- Check if on Windows or not
--@returns true if it is windows os, false otherwise
function M.is_windows()
    if os.getenv("HOME") == nil then
        return true
    end
    return false
end

--- Sets the shell to be used as bash, if not on windows
-- or OS is linux/mac
function M.do_term_open(terminal_task,term_options)
    vim.cmd("new")
    local shell = vim.o.shell
    if M.is_windows() ==false then
        vim.o.shell='/bin/bash'
    else
        vim.o.shell='cmd.exe'
    end
    vim.fn.termopen(terminal_task,term_options)
    vim.o.shell = shell
    vim.cmd("startinsert")
end

return M
