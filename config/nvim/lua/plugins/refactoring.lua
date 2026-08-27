return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = false,
	config = function()
		local refactoring = require("refactoring")
		refactoring.setup({
            -- show_success_message = true,
        })
		vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "refactor extract" })
		vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "refactor extract var" })
		vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "refactor inline var" })
		vim.keymap.set("n", "<leader>rI", ":Refactor inline_func", { desc = "refactor inline func" })
		vim.keymap.set("n", "<leader>rb", ":Refactor extract_block", { desc = "refactor inline var" })
		vim.keymap.set({ "n", "x" }, "<leader>rr", function()
			require("refactoring").select_refactor({prefer_ex_cmd = true})
		end, { desc = "refactor selection" })
	end,
}
