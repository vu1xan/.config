return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,

		-- show cwd in the winbar
		config = function()
			CustomOilBar = function()
				local path = vim.fn.expand("%")
				path = path:gsub("oil://", "")

				return "  " .. vim.fn.fnamemodify(path, ":.")
			end

			require("oil").setup({
				-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
				-- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
				default_file_explorer = true,
				-- Id is automatically added at the beginning, and name at the end
				-- See :help oil-columns
				columns = {
					"icon",
					"permissions",
					-- "size",
					-- "mtime",
				},
				-- Buffer-local options to use for oil buffers
				buf_options = {
					buflisted = false,
					bufhidden = "hide",
				},
				-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
				delete_to_trash = false,
				-- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
				skip_confirm_for_simple_edits = false,
				-- Selecting a new/moved/renamed file or directory will prompt you to save changes first
				-- (:help prompt_save_on_select_new_entry)
				prompt_save_on_select_new_entry = true,
				-- Oil will automatically delete hidden buffers after this delay
				-- You can set the delay to false to disable cleanup entirely
				-- Note that the cleanup process only starts when none of the oil buffers are currently displayed
				cleanup_delay_ms = 2000,
				-- Constrain the cursor to the editable parts of the oil buffer
				-- Set to `false` to disable, "name" to keep it on the file names, or "editable"
				constrain_cursor = "name",
				-- Set to true to watch the filesystem for changes and reload oil
				watch_for_changes = false,
				keymaps = {
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<C-k>"] = false,
					["<C-j>"] = false,
					["<M-h>"] = false,
				},
				-- Window-local options to use for oil buffers
				win_options = {
					-- 	wrap = false,
					-- 	signcolumn = "no",
					-- 	cursorcolumn = false,
					-- 	foldcolumn = "0",
					-- 	spell = false,
					-- 	list = false,
					-- 	conceallevel = 3,
					-- 	concealcursor = "nvic",
					winbar = "%{v:lua.CustomOilBar()}",
				},
				view_options = {
					-- Show files and directories that start with "."
					show_hidden = true,
					-- -- This function defines what is considered a "hidden" file
					-- is_hidden_file = function(name, bufnr)
					-- 	local m = name:match("^%.")
					-- 	return m ~= nil
					-- end,
					-- -- This function defines what will never be shown, even when `show_hidden` is set
					-- is_always_hidden = function(name, bufnr)
					-- 	local folder_skip = { -- folder names separated by commas }
					-- 	return vim.tbl_contains(folder_skip, name)
					-- end,
					-- 	return false
					-- end,
					-- Sort file names with numbers in a more intuitive order for humans.
					-- Can be "fast", true, or false. "fast" will turn it off for large directories.
					natural_order = "fast",
					-- Sort file and directory names case insensitive
					case_insensitive = false,
					sort = {
						-- sort order can be "asc" or "desc"
						-- see :help oil-columns to see which columns are sortable
						{ "type", "asc" },
						{ "name", "asc" },
					},
					-- -- Customize the highlight group for the file name
					-- highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
					-- 	return nil
					-- end,
				},
				-- Extra arguments to pass to SCP when moving/copying files over SSH
				extra_scp_args = {},
				-- Configuration for the floating window in oil.open_float
				float = {
					-- Padding around the floating window
					padding = 2,
					-- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
					max_width = 0.5,
					border = "rounded",
					max_height = 0.5,
					-- optionally override the oil buffers window title with custom function: fun(winid: integer): string
					get_win_title = nil,
					-- preview_split: Split direction: "auto", "left", "right", "above", "below".
					preview_split = "auto",
					-- This is the config that will be passed to nvim_open_win.
					-- Change values here to customize the layout
					override = function(conf)
						return conf
					end,
				},

				-- Configuration for the file preview window
				preview_win = {
					-- Whether the preview window is automatically updated when the cursor is moved
					update_on_cursor_moved = true,
					-- How to open the preview window "load"|"scratch"|"fast_scratch"
					preview_method = "fast_scratch",
					-- A function that returns true to disable preview on a file e.g. to avoid lag
					disable_preview = function(filename)
						return false
					end,
					-- Window-local options to use for preview window buffers
					win_options = {},
				},
			})

			-- Open parent directory in current window
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

			-- Open parent directory in floating window
			vim.keymap.set("n", "<space>-", require("oil").toggle_float, { desc = "oilfloat" })
		end,
	},
}
