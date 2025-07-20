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

require("config.plugins.rustaceanvim")
local plugins = {
	-- Lazy
	{ "folke/lazy.nvim" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.plugins.treesitter")
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
		},
		enabled = true,
		config = function()
			require("config.plugins.lsp")
		end,
	},

	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},

	-- Improved formatting
	{
		"stevearc/conform.nvim",
		config = function()
			require("config.plugins.conform")
		end,
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		enabled = true,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			{
				"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
				config = function()
					require("lsp_lines").setup()
				end,
			},
			{
				"saecki/crates.nvim",
				config = function()
					require("crates").setup()
				end,
			},
		},
		config = function()
			require("config.plugins.cmp")
		end,
	},

	-- Linting
	{
		"mfussenegger/nvim-lint",
		enabled = false,
		config = function()
			require("config.plugins.lint")
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		enabled = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.plugins.telescope")
		end,
	},

	-- Colorschemes
	{
		"rebelot/kanagawa.nvim",
		config = function()
			vim.cmd.colorscheme("kanagawa-dragon")
		end,
	},

	-- Go integration
	{
		"fatih/vim-go",
	},

	-- Markdown preview
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup({
				app = "browser",
			})
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},

	-- AI assistant
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			provider = "claude",
			auto_suggestions_provider = "claude",
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
}

local opts = {}

lazy.setup(plugins, opts)
