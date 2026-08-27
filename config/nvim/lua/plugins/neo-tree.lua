return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		close_if_last_window = true,
		popup_border_style = "rounded",
		filesystem = {
			filtered_items = {
				visible = true,
			},
			window = {
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
				},
				fuzzy_finder_mappings = {
					["<C-j>"] = "move_cursor_down",
					["<C-k>"] = "move_cursor_up",
				},
			},
			components = {
				harpoon_index = function(config, node, _)
					local Marked = require("harpoon.mark")
					local path = node:get_id()
					local success, index = pcall(Marked.get_index_of, path)
					if success and index and index > 0 then
						return {
							text = string.format("%d ", index), -- <-- Add your favorite harpoon like arrow here
							highlight = config.highlight or "NeoTreeDirectoryIcon",
						}
					else
						return {
							text = "  ",
						}
					end
				end,
			},
			renderers = {
				file = {
					{ "icon" },
					{ "name", use_git_status_colors = true },
					{ "harpoon_index" }, --> This is what actually adds the component in where you want it
					{ "diagnostics" },
					{ "git_status", highlight = "NeoTreeDimText" },
				},
			},
		},
        event_handlers = {
            {
                event = "file_open_requested",
                handler = function()
                    -- auto close
                    -- vim.cmd("Neotree close")
                    -- OR
                    require("neo-tree.command").execute({ action = "close" })
                end,
            },
        },
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)
		vim.keymap.set("n", "<leader>d", ":Neotree filesystem reveal left<CR>", { desc = "Show neotree fs" })
		vim.keymap.set("n", "<leader>bn", ":Neotree buffers reveal float<CR>", { desc = "Show neotree buffer float" })
	end,
}
