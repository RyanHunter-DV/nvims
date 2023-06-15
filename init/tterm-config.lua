
require("toggleterm").setup{
	direction= float
}
-- set
vim.cmd([[au TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR> ]])
--vim.cmd([[au FileType systemverilog lua require('sv.init') ]])

-- By applying the mappings this way you can pass a count to your
-- mapping to open a specific window.
-- For example: 2<C-t> will open terminal 2
--nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
--inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
vim.keymap.set('n', '<c-t>', "<Cmd>exe v:count1 . 'ToggleTerm direction=float'<CR>", {noremap=true,silent=true})
vim.keymap.set('i', '<c-t>', '<Esc><Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', {noremap=true,silent=true})