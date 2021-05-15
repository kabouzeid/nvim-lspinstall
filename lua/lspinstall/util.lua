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

return M
