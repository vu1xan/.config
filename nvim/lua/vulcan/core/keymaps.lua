-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- HACK: there could be better ways to do it
-- Set colorscheme and transparency

local function solid()
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = vim.api.nvim_get_hl_by_name("Normal", true).background })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = vim.api.nvim_get_hl_by_name("Normal", true).background })
end

local function transparent()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "none" })
end

local function sexyLingerie()
	if transToggle == "solid" then
		transparent()
		transToggle = "trans"
	else
		vim.cmd.colorscheme(vim.g.colors_name)
		solid()
		transToggle = "solid"
	end
end

transToggle = "solid"
-- color set to either golbal predefined colorscheme or habamax
vim.cmd.colorscheme("habamax")

-- color = vim.g.colors_name or "habamax"
solid()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		solid()
		transToggle = "solid"
	end,
})

-- toggle transparency
keymap.set("n", "ZZ", sexyLingerie, { desc = "toggle transparency" })

keymap.set("n", "Zw", ":wq<cr>", { desc = "wq" })
keymap.set("n", "ZW", ":wq!<cr>", { desc = "wq!" })

------------------- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- disable arrow keys
keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- clear search highlights
keymap.set("n", "<Esc>", ":nohl<CR>")

-- navigate buffers
keymap.set("n", "al", ":bnext<CR>", { desc = "next buffer" })
keymap.set("n", "la", ":bprev<CR>", { desc = "prev buffer" })

keymap.set("n", "<tab>", "<cmd>tabn<CR>", { desc = "next tab" })
keymap.set("n", "S-<tab>", "<cmd>tabp<CR>", { desc = "previous tab" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Zen Mode
keymap.set("n", "<leader><leader>", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })

-- -- File Rename
-- keymap.set("n", "<F2>", function()
-- 	local new_name = vim.fn.input("New filename: ")
-- 	local old_name = vim.fn.expand("%")
-- 	local old_bufnr = vim.fn.bufnr("%")
--
-- 	-- If new name is empty, ask if the user really wants to delete the old file
-- 	if new_name == "" then
-- 		local confirm = vim.fn.confirm("New filename is empty. Delete old file anyway?", "&Yes\n&No", 2)
-- 		if confirm ~= 1 then
-- 			print("Operation cancelled.")
-- 			return
-- 		end
-- 	else
-- 		-- Save the current buffer as the new file
-- 		vim.cmd("write " .. vim.fn.fnameescape(new_name))
-- 		-- Edit the new file
-- 		vim.cmd("edit " .. vim.fn.fnameescape(new_name))
-- 	end
--
-- 	-- Check if old buffer has unsaved changes
-- 	if vim.bo[old_bufnr].modified then
-- 		local confirm = vim.fn.confirm("Old buffer has unsaved changes. Force close?", "&Yes\n&No", 2)
-- 		if confirm ~= 1 then
-- 			print("File copy has been generated with new name : " .. new_name .. "")
-- 			return
-- 		end
-- 	end
--
-- 	-- Delete the old file from the filesystem
-- 	vim.fn.system("rm " .. vim.fn.shellescape(old_name))
--
-- 	-- Delete the old buffer forcibly
-- 	vim.cmd("bdelete! " .. old_bufnr)
--
-- 	if new_name == "" then
-- 		print("Old file deleted with no new file saved.")
-- 	else
-- 		print("File renamed to " .. new_name .. ", old file deleted.")
-- 	end
-- end, { noremap = true, silent = true, desc = "rename file" })
