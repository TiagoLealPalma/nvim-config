-- Editor autocmds for quality-of-life behaviors.
-- Loaded from init.lua after plugins and keymaps.

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.defer_fn(function()
        require("telescope").extensions.projects.projects({})
      end, 0)
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})
