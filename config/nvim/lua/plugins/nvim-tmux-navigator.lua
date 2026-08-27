return {
    "christoomey/vim-tmux-navigator",
    vim.keymap.set("n", "C-h", ":TmuxNavigateLeft k<CR>", { desc = "move focus to Tmux window left" }),
    vim.keymap.set("n", "C-j", ":TmuxNavigateDown k<CR>", { desc = "move focus to Tmux window down" }),
    vim.keymap.set("n", "C-k", ":TmuxNavigateUp k<CR>", { desc = "move focus to Tmux window up" }),
    vim.keymap.set("n", "C-l", ":TmuxNavigateRight k<CR>", { desc = "move focus to Tmux window right" })
}
