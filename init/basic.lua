vim.wo.cursorline = true
vim.wo.number     = true
vim.o.ts          = 4
vim.o.shiftwidth  = 4
vim.o.incsearch   = true
vim.o.hlsearch    = true
vim.o.cindent     = true

vim.cmd ([[ set foldmethod=marker ]])
vim.cmd ([[ set foldmarker=##{{{,##}}} ]])
vim.cmd ([[au BufRead,BufNewFile *.rh set filetype=ruby]])
vim.cmd ([[au FileType ruby setlocal shiftwidth=4 ]])
vim.cmd ([[au FileType * setlocal fo-=o ]])
vim.cmd ([[au FileType * set softtabstop=0 ]])
vim.cmd ([[au FileType * set noexpandtab ]])
vim.cmd ([[au BufRead,BufNewFile *.svh set filetype=systemverilog]])
--vim.cmd ([[]])

