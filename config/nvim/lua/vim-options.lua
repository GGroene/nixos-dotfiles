vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.smartindent = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.inccommand = 'split'

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 4
vim.opt.isfname:append("@-@")

vim.opt.virtualedit = "block"

vim.opt.cursorline = true
vim.opt.colorcolumn = "120"

vim.opt.winborder = 'rounded'

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""


vim.g.mapleader = " "
-- vim.g.background = "light"

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "move focus to window above" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "move focus to window below" })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "move focus to window left " })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "move focus to window right" })

vim.keymap.set("n", "<leader>wk", ":wincmd k<CR>", { desc = "move focus to window above" })
vim.keymap.set("n", "<leader>wj", ":wincmd j<CR>", { desc = "move focus to window below" })
vim.keymap.set("n", "<leader>wh", ":wincmd h<CR>", { desc = "move focus to window left " })
vim.keymap.set("n", "<leader>wl", ":wincmd l<CR>", { desc = "move focus to window right" })
vim.keymap.set("n", "<leader>wv", ":wincmd v<CR>", { desc = "vertical split window" })
vim.keymap.set("n", "<leader>ws", ":wincmd s<CR>", { desc = "horizontal split window" })
vim.keymap.set("n", "<leader>wq", ":wincmd q<CR>", { desc = "close window" })

-- remappings
vim.keymap.set("n", "J", "mzJ'z", { desc = "" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "" })
vim.keymap.set("n", "n", "nzzzv", { desc = "" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "" })

vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "pop without overwriting register" })

vim.keymap.set("n", "<leader>y", "\"+y", { desc = "yank to system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "yank to system clipboard" })


local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    if vim.fn.has("nvim-0.13") == 1 then
      vim.hl.hl_op()
    else
      (vim.hl or vim.highlight).on_yank()
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
