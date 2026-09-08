-- Treesitter configuration for syntax highlighting and indentation.
-- Loaded by lazy.nvim. Parsers are auto-installed on first use via ensure_installed.

local ok, ts = pcall(require, "nvim-treesitter.configs")
if not ok then
  vim.notify("nvim-treesitter not available", vim.log.levels.WARN)
  return
end

ts.setup({
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",
    "json",
    "lua",
    -- markdown + markdown_inline required by render-markdown.nvim; yaml is
    -- optional there but used for frontmatter rendering.
    "markdown",
    "markdown_inline",
    "yaml",
  },
  highlight = { enable = true },
  indent = { enable = true },
})
