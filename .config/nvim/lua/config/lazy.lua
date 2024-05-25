-- Bootstrap lazy.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)


local lazy = require("lazy")

require('config.plugins.rustaceanvim')
local plugins = {
  -- Lazy
  { "folke/lazy.nvim" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("config.plugins.treesitter")
    end
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim"
    },
    config = function()
      require("config.plugins.lsp")
    end
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },

  -- Improved formatting
  {
    "stevearc/conform.nvim",
    config = function()
      require("config.plugins.conform")
    end
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "Maan2003/lsp_lines.nvim",
      {
        "saecki/crates.nvim",
        config = function()
          require('crates').setup()
        end
      }
    },
    config = function()
      require("config.plugins.cmp")
    end
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    config = function()
      require('config.plugins.lint')
    end
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("config.plugins.telescope")
    end
  },

  -- Colorschemes
  {
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd.colorscheme("kanagawa-dragon")
    end
  },

  -- Go integration
  {
    "fatih/vim-go"
  }
}

local opts = {
}

lazy.setup(plugins, opts)
