return {
	{
		"VonHeikemen/lsp-zero.nvim",
		lazy = false,
		branch = "v3.x",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function(_, _)
			local lsp = require("lsp-zero")

			lsp.set_sign_icons({
				error = "",
				warn = "",
				hint = "󰮦",
				info = "",
			})

			lsp.set_server_config({
				capabilities = {
					textDocument = {
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
				},
			})

			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({
					buffer = bufnr,
					preserve_mappings = false,
				})
				if client.server_capabilities.inlayHintProvider then
					vim.keymap.set("n", "gh", function()
						vim.lsp.inlay_hint(bufnr)
					end, {
						silent = true,
						buffer = bufnr,
						desc = "Toggle Inlay Hints",
					})
				end
				vim.keymap.set(
					"n",
					"gr",
					"<cmd>Telescope lsp_references<cr>",
					{ silent = true, buffer = bufnr, desc = "References" }
				)
			end)

			require("mason").setup({})
			require("mason-lspconfig").setup({
				handlers = {
					lsp.default_setup,
				},
			})
			-- run overriden lspconfig
			require("kiro.lspconfig")
		end,
	},
	{ "folke/neodev.nvim", ft = "lua", opts = {} },
}
