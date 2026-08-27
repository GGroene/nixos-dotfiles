return {
    "ThePrimeagen/harpoon",
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        vim.keymap.set("n", "<leader>am", mark.add_file, { desc = "harpoon mark" })
        vim.keymap.set("n", "<leader>af", ui.toggle_quick_menu, { desc = "harpoon menu" })
        vim.keymap.set("n", "<leader>aj", function() ui.nav_file(1) end, { desc = "harpoon 1" })
        vim.keymap.set("n", "<leader>ak", function() ui.nav_file(2) end, { desc = "harpoon 2" })
        vim.keymap.set("n", "<leader>al", function() ui.nav_file(3) end, { desc = "harpoon 3" })
        vim.keymap.set("n", "<leader>a;", function() ui.nav_file(4) end, { desc = "harpoon 4" })
    end
}
