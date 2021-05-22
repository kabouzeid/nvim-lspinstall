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
    local home_dir = os.getenv("HOME")
    if home_dir == nil then
        -- normally only windows users haven't defined this env variable
        return true
    else
        -- just incase a user has defined it and is on windows
        -- check that ':' is contained in index 2, if so then it is windows
        -- otherwise it's linux
        local result = string.find(home_dir,':')
        if result == 2 then
            return true
        end
    end
    return false
end

--- Sets the shell to be used as bash, if not on windows
-- or OS is linux/mac, cmd.exe if on windows while executing the command
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
