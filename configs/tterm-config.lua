local s={};
s.setup = function(home)
	package.path=package.path..string.format(";%s/plugins/tterm/lua/?.lua",home);
	require("toggleterm").setup{
		direction   = 'horizontal',
		open_mapping= [[<c-t>]],
		on_open = function()
			vim.cmd('set mouse=n');
		end,
		on_close = function()
			vim.cmd('set mouse=');
		end,
		float_opts = {
			width = vim.o.columns-3,
			height= vim.o.lines-3
		}
	}
	-- set
	vim.cmd([[au TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR> ]])
	--vim.cmd([[au FileType systemverilog lua require('sv.init') ]])
	
	-- By applying the mappings this way you can pass a count to your
	-- mapping to open a specific window.
	-- For example: 2<C-t> will open terminal 2
	--nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
	--inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
	--vim.keymap.set('n', '<c-t>', "<Cmd>exe v:count1 . 'ToggleTerm direction=float'<CR>", {noremap=true,silent=true})
	--vim.keymap.set('i', '<c-t>', '<Esc><Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', {noremap=true,silent=true})
	vim.keymap.set('n', 'tt', "<Cmd>exe v:count1 . 'ToggleTerm direction=float'<CR>", {noremap=true,silent=true})
end

return s;
