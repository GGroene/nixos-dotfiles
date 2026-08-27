return {
    'tanvirtin/vgit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    -- Lazy loading on 'VimEnter' event is necessary.
    event = 'VimEnter',
    config = function()
        require("vgit").setup({
            keymaps = {
                ['n <leader>g<C-k>'] = function() require('vgit').hunk_up() end,
                {
                    mode = 'n',
                    key = '<leader>g<C-j>',
                    handler = 'hunk_down',
                    desc = 'Go down in the direction of the hunk',
                },
            },
        })
        vim.keymap.set('n', '<leader>ggs', function() require('vgit').buffer_hunk_stage() end, { desc = 'buffer_hunk_stage' })
        vim.keymap.set('n', '<leader>ggr', function() require('vgit').buffer_hunk_reset() end, { desc = 'buffer_hunk_reset' })
        vim.keymap.set('n', '<leader>ggp', function() require('vgit').buffer_hunk_preview() end, { desc = 'buffer_hunk_preview' })
        vim.keymap.set('n', '<leader>ggb', 'buffer_blame_preview', { desc = 'buffer_blame_preview' })
        vim.keymap.set('n', '<leader>ggf', function() require('vgit').buffer_diff_preview() end, { desc = 'buffer_diff_preview' })
        vim.keymap.set('n', '<leader>ggh', function() require('vgit').buffer_history_preview() end, { desc = 'buffer_history_preview' })
        vim.keymap.set('n', '<leader>ggu', function() require('vgit').buffer_reset() end, { desc = 'buffer_reset' })
        vim.keymap.set('n', '<leader>ggd', function() require('vgit').project_diff_preview() end, { desc = 'project_diff_preview' })
        vim.keymap.set('n', '<leader>ggx', function() require('vgit').toggle_diff_preference() end, { desc = 'toggle_diff_preference' })
    end,
}
