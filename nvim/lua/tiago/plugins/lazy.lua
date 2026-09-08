-- Plugin manager bootstrap and plugin declarations.
-- Loaded from init.lua right after core/options.
-- Each plugin's config callback requires its corresponding file under plugins/.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "folke/tokyonight.nvim", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "AlexvZyl/nordic.nvim", lazy = false },

  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function()
      require("tiago.plugins.smart-splits")
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("tiago.plugins.nvim-tree")
    end,
  },

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("tiago.plugins.alpha")
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("tiago.plugins.indent-blankline")
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("tiago.plugins.telescope")
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("tiago.plugins.project")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    -- The "main" branch (this repo's default) was rewritten from scratch and
    -- requires Neovim 0.12+ nightly — it dropped the nvim-treesitter.configs
    -- module our config.lua below expects, causing a "nvim-treesitter not
    -- available" notice on every startup. "master" is the old branch with
    -- the stable, pre-rewrite API that still works on stable Neovim.
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("tiago.plugins.treesitter")
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown", -- also covers markdown injected into other filetypes' code blocks
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("tiago.plugins.render-markdown")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("tiago.plugins.lualine")
    end,
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("tiago.plugins.bufferline")
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("tiago.plugins.comment")
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("tiago.plugins.autopairs")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("tiago.plugins.gitsigns")
    end,
  },

  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "jsonls",
      },
    },
  },
  {
    -- mason-lspconfig's ensure_installed only covers LSP servers; prettier
    -- is a standalone formatter conform.nvim shells out to, so it needs
    -- this separate installer to get the same "auto-provision on a fresh
    -- machine" treatment instead of a manual :MasonInstall prettier.
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "prettier" },
    },
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("tiago.plugins.conform")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("tiago.plugins.lsp")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      require("tiago.core.completion")
    end,
  },
})
