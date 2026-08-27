return {
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		name = "dracula",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("dracula")
			require("dracula").setup({
				italic_comment = true,
				transparent = vim.g.transparent_enabled,
			})
		end,
	},
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		vim.cmd.colorscheme("rose-pine")
	-- 		require("rose-pine").setup({
	-- 			variant = "auto", -- auto, main, moon, dawn
	-- 			styles = {
	-- 				bold = true,
	-- 				italic = false,
	-- 				transparent = false,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"olimorris/onedarkpro.nvim",
	-- 	config = function()
	-- 		vim.cmd.colorscheme("onedark")
	-- 	end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	config = function()
	-- 		-- vim.cmd.colorscheme("catppuccin-latte")
	-- 		-- vim.cmd.colorscheme("catppuccin-frappe")
	-- 		-- vim.cmd.colorscheme("catppuccin-macchiato")
	-- 		vim.cmd.colorscheme("catppuccin-mocha")
	-- 	end,
	-- },
	-- {
	-- 	"dgox16/oldworld.nvim",
	-- 	config = function()
	-- 		vim.cmd.colorscheme("oldworld")
	-- 	end,
	-- },
}
