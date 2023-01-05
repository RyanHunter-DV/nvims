vim.wo.cursorline = true
vim.wo.number     = true
vim.o.ts          = 4
vim.o.shiftwidth  = 4
vim.o.incsearch   = true
vim.o.hlsearch    = true
vim.o.cindent     = true

vim.cmd [[au BufRead,BufNewFile *.rh set filetype=ruby]]
vim.cmd [[au BufRead,BufNewFile *.svh set filetype=systemverilog]]
