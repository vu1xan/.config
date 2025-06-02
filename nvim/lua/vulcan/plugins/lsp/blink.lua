return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "",
							package_pending = "",
							package_uninstalled = "",
						},
					},
				},
			},
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- 👇 IMPORTANT: Don't add () after function names in mappings!
					-- Doing so calls the function immediately and passes its *result* (often nil),
					-- instead of passing the function *itself* as a callback.

					map("gl", vim.diagnostic.open_float, "[l]ine diagnostics")
					map("[d", vim.diagnostic.goto_prev, "[p]rev diagnostic")
					map("]d", vim.diagnostic.goto_next, "[n]ext diagnostic")

					map("K", vim.lsp.buf.hover, "definition for what's under the curson")

					map("gr", "<nop>", "g[r]oup")
					map("gra", vim.lsp.buf.code_action, "code [a]ctions", { "n", "x" })
					map("grn", vim.lsp.buf.rename, "smart [r]e[n]ame")
					map("grr", require("telescope.builtin").lsp_references, "[r]eferences")
					map("gri", require("telescope.builtin").lsp_implementations, "[i]mplementation")

					map("gd", require("telescope.builtin").lsp_definitions, "[d]efinitions")
					map("gD", vim.lsp.buf.declaration, "[D]eclaration")
					map("gt", require("telescope.builtin").lsp_type_definitions, "[t]ype definitions")

					map("gO", require("telescope.builtin").lsp_document_symbols, "[O]pen document symbols")
					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "open [W]orkspace symbols")
					map("gs", vim.lsp.buf.signature_help, "signature help")

					map("<leader><F8>", "<cmd>LspRestart<cr>", "restart LSP")

					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[t]oggle Inlay [h]ints")
					end
				end,
			})

			vim.diagnostic.config({
				virtual_text = false,
				severity_sort = true,
				update_in_insert = true,
				float = {
					focusable = false,
					-- style = "minimal",
					border = "rounded",
					source = true,
				},
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				-- virtual_text = {
				-- 	source = "if_many",
				-- 	spacing = 2,
				-- 	format = function(diagnostic)
				-- 		local diagnostic_message = {
				-- 			[vim.diagnostic.severity.ERROR] = diagnostic.message,
				-- 			[vim.diagnostic.severity.WARN] = diagnostic.message,
				-- 			[vim.diagnostic.severity.INFO] = diagnostic.message,
				-- 			[vim.diagnostic.severity.HINT] = diagnostic.message,
				-- 		}
				-- 		return diagnostic_message[diagnostic.severity]
				-- 	end,
				-- },
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local servers = {
				rust_analyzer = {},
				ruff = {},
				pyright = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				-- "stylua", -- Used to format Lua code
				-- "rustfmt",
				-- "ruff",
				"pyright",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<F3>",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "format buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,

			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff" },
				rust = { "rustfmt" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},

	{ -- Autocompletion
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {},
				opts = {},
			},
			"folke/lazydev.nvim",
		},
		opts = {
			keymap = {
				preset = "default",
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				documentation = { auto_show = false, auto_show_delay_ms = 500 },
			},

			sources = {
				default = { "lsp", "path", "snippets", "lazydev" },
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},

			snippets = { preset = "luasnip" },

			fuzzy = { implementation = "lua" },

			signature = { enabled = true },
		},
	},
}
