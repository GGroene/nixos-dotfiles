return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
        },
        config = function()
            pcall(require('telescope').load_extension, 'fzf')
            -- require("telescope").setup({defaults = {initial_mode="normal"}})
            -- local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "find files" })
            vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "live grep" })
            vim.keymap.set("n", "<leader>bf", "<cmd>Telescope buffers<CR><Esc>", { desc = "Telescope buffers" })
            vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help tags" })
            vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR><Esc>", { desc = "Telescope file history" })
            vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Telescope marks" })
            vim.keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<CR><Esc>", { desc = "Telescope quick fix" })
            vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR><Esc>", { desc = "Telescope keymaps" })
            vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope <CR><Esc>", { desc = "Telescope Todo" })
            vim.keymap.set("n", "<leader>fp", "<cmd>Telescope builtin<CR><Esc>", { desc = "Telescope all builtins" })
            vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        require("telescope.builtin").current_buffer_fuzzy_find()
      end, { desc = '[/] Fuzzily search in current buffer' })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
                defaults = {
                        preview = {
                                treesitter = false,
                            },
                    },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
