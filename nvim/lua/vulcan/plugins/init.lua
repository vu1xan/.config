return {

	-- lua functions that many plugins use
	{ "nvim-lua/plenary.nvim" },

	-- icons
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{ "echasnovski/mini.icons", version = "*" },

	-- autopairs
	-- https://github.com/windwp/nvim-autopairs

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{
		"christoomey/vim-tmux-navigator", -- nvim & tmux navigator
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	{
		"folke/zen-mode.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			window = {
				-- height and width can be:
				-- * an absolute number of cells when > 1
				-- * a percentage of the width / height of the editor when <= 1
				-- * a function that returns the width or the height
				width = 135,
				height = 1, -- height of the Zen window,
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
			"folke/todo-comments.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					path_display = { "smart" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send to quick fix list and open it
						},
					},
				},
			})

			telescope.load_extension("fzf")
		end,
	},

	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local todo_comments = require("todo-comments")

			-- set keymaps
			local keymap = vim.keymap

			keymap.set("n", "]t", function()
				todo_comments.jump_next()
			end, { desc = "Next todo comment" })

			keymap.set("n", "[t", function()
				todo_comments.jump_prev()
			end, { desc = "Previous todo comment" })

			todo_comments.setup()
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },

		config = function()
			-- Import comment plugin safely
			local comment = require("Comment")

			-- Assuming Comment.ft is part of the same plugin or available separately
			local ft = require("Comment.ft")

			-- 1. Using set function
			-- Set only line comment for yaml files
			ft.set("yaml", "#%s")
			-- Set both line and block commentstring for rust files
			ft.set("rust", { "//%s", "/*%s*/" })

			-- Enable comment
			comment.setup({})

			-- Optionally, if you want to use metatable magic as shown in point 2,
			-- you would place that logic here as well. However, based on your initial request,
			-- it seems like you're focusing on the first approach.
		end,
	},

	-- TODO: plugins that i may use:
	-- undotree, some sort of git integration
}
