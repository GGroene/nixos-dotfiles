return {
  "stevearc/oil.nvim",
  config = function()
    local oil = require("oil")
    oil.setup({
      keymaps = {
        ["<Esc>"] = { "actions.close", mode = "n" },
      },
    })
    vim.keymap.set("n", "-", oil.toggle_float, {})
  end,
}
