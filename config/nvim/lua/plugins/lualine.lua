return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "dracula",
			},
            sections = {
                lualine_c = {
                    {
                        'filename',
                        path = 1
                    }
                },
                lualine_y = {
                    'progress', 'location'
                },
                lualine_z = {
                    'lsp_status',
                    {
                        'datetime',
                        style = "%d-%m %H:%M"
                    }
                },
            },
		})
	end,
}
