return {
	{
		"ellisonleao/carbon-now.nvim",
		lazy = true,
		cmd = "CarbonNow",
		opts = {},
	},
	{
		"michaelrommel/nvim-silicon",
		cmd = "Silicon",
		lazy = false,
		config = function()
			local silicon = require("nvim-silicon")
			silicon.setup({
				theme = "Dracula",
				window_title = function()
					return vim.fn.fnamemodify(
                        vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
                        ":t"
                    )
				end,
			})
			vim.keymap.set("x", "<leader>sc", ":Silicon<CR>", { desc = "snapshot code" })
		end,
	},
}
