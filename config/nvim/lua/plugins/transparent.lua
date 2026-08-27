return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  config = function()
    require("transparent").setup()
    require("transparent").clear_prefix("NeoTree")
    require("transparent").clear_prefix("telescope")
    vim.keymap.set("n", "<leader>tt", function() vim.cmd("TransparentToggle") end, { desc = "Toggle transparency" })
  end,
}
