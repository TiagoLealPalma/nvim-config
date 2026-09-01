-- Editor autocmds for quality-of-life behaviors.
-- Loaded from init.lua after plugins and keymaps.

-- Only show the project picker when nvim is opened with no args outside of
-- a project (e.g. bare `nvim` from $HOME). If cwd is already a git repo
-- (e.g. opened via the `dev` tmux launcher), just open normally.
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local in_git_repo = vim.fn.isdirectory(vim.fn.getcwd() .. "/.git") == 1
    if vim.fn.argc() == 0 and not in_git_repo then
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
