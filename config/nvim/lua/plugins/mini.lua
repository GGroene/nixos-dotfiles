return {
    {
        "echasnovski/mini.surround",
        opts = {
            mappings = {
                add = "gsa", -- Add surrounding in Normal and Visual modes
                delete = "gsd", -- Delete surrounding
                find = "gsf", -- Find surrounding (to the right)
                find_left = "gsF", -- Find surrounding (to the left)
                highlight = "gsh", -- Highlight surrounding
                replace = "gsr", -- Replace surrounding
                update_n_lines = "gsn", -- Update `n_lines`
            },
        },
    },
    {
        "echasnovski/mini.splitjoin",
        opts = {
            mappings = {
                toggle = "gS",
                split = "",
                join = "",
            },
        },
        config = function(opts)
            require("mini.splitjoin").setup(opts)
        end,
    },
    {
        "echasnovski/mini.move",
        opts = {
            mappings = {
                -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                left = "<M-h>",
                right = "<M-l>",
                down = "<M-j>",
                up = "<M-k>",

                -- Move current line in Normal mode
                line_left = "<M-h>",
                line_right = "<M-l>",
                line_down = "<M-j>",
                line_up = "<M-k>",
            },
            -- Options which control moving behavior
            options = {
                -- Automatically reindent selection during linewise vertical move
                reindent_linewise = true,
            },
        },
        config = function(opts)
            require("mini.move").setup(opts)
        end,
    },
    -- {
    --     "echasnovski/mini.starter",
    --     opts = {},
    --     config = function(opts)
    --         require("mini.starter").setup(opts)
    --     end,
    -- },
}
