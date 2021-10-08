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

-- Gets yarn or node from system (default: yarn, fallback: npm)
--@returns yarn/npm install script
function M.get_node_install_script(pkg_name)
    return string.format([[
    if command -v yarn 2>/dev/null; then
      # yarn was found
      printf "\nfound yarn\n"
      ! test -f package.json && yarn init -y --scope=lspinstall || true
      yarn add %s --ignore-engines
    else
      # yarn was not found
      printf "\ncannot find yarn\n"
      ! test -f package.json && npm init -y --scope=lspinstall || true
      npm install %s
    fi
    ]], pkg_name, pkg_name)
end

return M
