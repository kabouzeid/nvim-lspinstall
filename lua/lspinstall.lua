local servers = require'lspinstall/servers'
local configs = require'lspconfig/configs'

local M = {}

-- UTILITY

local function install_path(lang)
  return vim.fn.stdpath("data") .. "/lspinstall/" .. lang
end

-- INSTALL

function M.install_server(lang)
  if not servers[lang] then
    error("there is no server with the name " .. lang)
  end

  if vim.fn.confirm("Install " .. lang .. " language server?", "&Yes\n&Cancel") ~= 1 then
    return
  end

  local path = install_path(lang)
  if os.execute("mkdir -p " .. path) ~= 0 then
    error("could not create directory " .. lang)
  end

  local function onExit(_, code)
    if code ~= 0 then
      error("Could not install " .. lang .. " language server!")
    end
    print("Successfully installed " .. lang .. " language server!")
    if M.post_install_hook then M.post_install_hook() end
  end

  vim.cmd("new")
  local shell = vim.o.shell
  vim.o.shell = '/bin/bash'
  vim.fn.termopen("set -e\n" .. servers[lang].install_script, {["cwd"] = path, ["on_exit"] = onExit})
  vim.o.shell = shell
  vim.cmd("startinsert")
end

-- UNINSTALL

function M.uninstall_server(lang)
  if not servers[lang] then
    error("there is no server with the name " .. lang)
  end

  local path = install_path(lang)

  if os.execute("test -d " .. path) ~= 0 then
    error("server is not installed")
  end

  if vim.fn.confirm("Uninstall " .. lang .. " language server?", "&Yes\n&Cancel") ~= 1 then
    return
  end

  local function onExit(_, code)
    if code ~= 0 then
      error("Could not uninstall " .. lang .. " language server!")
    end
    if os.execute("rm -rf " .. path) ~= 0 then
      error("could not delete directory " .. lang)
    end
    print("Successfully uninstalled " .. lang .. " language server!")
    if M.post_uninstall_hook then M.post_uninstall_hook() end
  end

  vim.cmd("new")
  local shell = vim.o.shell
  vim.o.shell = '/bin/bash'
  vim.fn.termopen("set -e\n" .. (servers[lang].uninstall_script or ""), {["cwd"] = path, ["on_exit"] = onExit})
  vim.o.shell = shell
  vim.cmd("startinsert")
end

-- UTILITY

function M.is_server_installed(lang)
  return os.execute("test -d " .. install_path(lang)) == 0
end

function M.available_servers()
  return vim.tbl_keys(servers)
end

function M.installed_servers()
  return vim.tbl_filter(function(key) return M.is_server_installed(key) end, M.available_servers())
end

function M.not_installed_servers()
  return vim.tbl_filter(function(key) return not M.is_server_installed(key) end, M.available_servers())
end

function M.setup()
  for lang, server_config in pairs(servers) do
    if M.is_server_installed(lang) and not configs[lang] then -- don't overwrite any configs set by the user
      local config = vim.tbl_deep_extend("keep", server_config, {
        default_config = {
          cmd_cwd = install_path(lang)
        }
      })
      local executable = config.default_config.cmd[1]
      if vim.regex([[^[.]\{1,2}\/]]):match_str(executable) then -- matches ./ and ../
        -- prepend the install path if the executable is a relative path
        -- we need this because for the executable cmd[1] itself, cwd is not considered!
        config.default_config.cmd[1] = install_path(lang) .. "/" .. executable
      end
      configs[lang] = config
    end
  end
end

return M
