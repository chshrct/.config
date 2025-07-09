local path = require("plenary.path")
local json = vim.json

local function load_server_config(server_name)
  local config_path = vim.fn.stdpath("config") .. "/lua/plugins/lsp/configs/" .. server_name .. ".json"
  local file = path:new(config_path)

  if not file:exists() then
    vim.notify("Config file not found for " .. server_name .. ": " .. config_path, vim.log.levels.WARN)
    return {}
  end

  local content = file:read()
  local ok, config = pcall(json.decode, content)

  if not ok then
    vim.notify("Failed to parse JSON config for " .. server_name .. ": " .. config, vim.log.levels.ERROR)
    return {}
  end

  return config
end

local M = {
  lua_ls = load_server_config("lua_ls"),

  -- Web
  cssls = load_server_config("cssls"),
  html = load_server_config("html"),
  graphql = load_server_config("graphql"),
  cssmodules_ls = load_server_config("cssmodules_ls"),
  tailwindcss = load_server_config("tailwindcss"),
  eslint = load_server_config("eslint"),
  hyprls = load_server_config("hyprls"),

  -- Languages
  csharp_ls = load_server_config("csharp_ls"),
  vtsls = load_server_config("vtsls"),

  -- Config files
  jsonls = (function()
    local config = load_server_config("jsonls")
    config.settings = config.settings or {}
    config.settings.json = config.settings.json or {}
    config.settings.json.schemas = require("schemastore").json.schemas()
    return config
  end)(),

  yamlls = (function()
    local config = load_server_config("yamlls")
    config.settings = config.settings or {}
    config.settings.yaml = config.settings.yaml or {}
    config.settings.yaml.schemas = require("schemastore").yaml.schemas()
    return config
  end)(),

  taplo = load_server_config("taplo"),
}

return M
