-- Formatter configuration via conform.nvim.
-- Prettier runs only when a prettier config is found in the project tree,
-- so projects without prettier are left untouched.
-- Install the binary once with :MasonInstall prettier

local function has_prettier_config(ctx)
  local config_files = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
    "prettier.config.mjs",
  }

  if vim.fs.find(config_files, { path = ctx.filename, upward = true })[1] then
    return true
  end

  local pkg = vim.fs.find("package.json", { path = ctx.filename, upward = true })[1]
  if pkg then
    local ok, data = pcall(function()
      return vim.fn.json_decode(table.concat(vim.fn.readfile(pkg), "\n"))
    end)
    return ok and data ~= nil and data.prettier ~= nil
  end

  return false
end

require("conform").setup({
  formatters_by_ft = {
    javascript      = { "prettier" },
    javascriptreact = { "prettier" },
    typescript      = { "prettier" },
    typescriptreact = { "prettier" },
    css             = { "prettier" },
    html            = { "prettier" },
    json            = { "prettier" },
    jsonc           = { "prettier" },
    yaml            = { "prettier" },
    markdown        = { "prettier" },
  },
  formatters = {
    prettier = {
      condition = has_prettier_config,
    },
  },
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = false,
  },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
  require("conform").format({ timeout_ms = 2000, lsp_fallback = false })
end, { desc = "Format buffer" })
