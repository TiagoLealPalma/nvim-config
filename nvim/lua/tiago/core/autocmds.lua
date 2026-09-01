-- Editor autocmds for quality-of-life behaviors.
-- Loaded from init.lua after plugins and keymaps.

-- On opening nvim with no args: if cwd is already a git repo (e.g. opened
-- via the `dev` tmux launcher), jump straight to the file finder. Otherwise
-- (e.g. bare `nvim` from $HOME) show the project picker to pick one.
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local in_git_repo = vim.fn.isdirectory(vim.fn.getcwd() .. "/.git") == 1
    if vim.fn.argc() ~= 0 then
      return
    end
    vim.defer_fn(function()
      if in_git_repo then
        require("telescope.builtin").find_files()
      else
        require("telescope").extensions.projects.projects({})
      end
    end, 0)
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})
