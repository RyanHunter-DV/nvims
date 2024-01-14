local s={}
s.setup=function(home)
	-- local ls = require('luasnip').setup()
	local snips_status_ok,luasnip = pcall(require,'luasnip')
	if not snips_status_ok then
		-- vim.vim_notify('luasnip not found')
		return
	end
	-- " press <Tab> to expand or jump in a snippet. These can also be mapped separately
	-- " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
	-- vim.keymap.set('i', '<silent><expr> <Tab>', "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", {})
	-- " -1 for jumping backwards.
	vim.keymap.set('i', '<c-k>', "<cmd>lua require('luasnip').jump(-1)<Cr>", {noremap=true,silent=true})
	vim.keymap.set('i', '<c-j>'  , "<cmd>lua require('luasnip').jump(1)<Cr>" , {noremap=true,silent=true})
	vim.keymap.set('s', '<c-j>'  , "<cmd>lua require('luasnip').jump(1)<Cr>" , {noremap=true,silent=true})
	vim.keymap.set('s', '<c-k>', "<cmd>lua require('luasnip').jump(-1)<Cr>", {noremap=true,silent=true})
	
	-- " For changing choices in choiceNodes (not strictly necessary for a basic setup).
	-- vim.keymap.set('i', '<silent><expr> <C-E>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", {})
	-- press <Tab> to expand or jump in a snippet. These can also be mapped separately
	-- vim.keymap.set('s', '<silent><expr> <C-E>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'" , {})
	-- " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
	-- vim.keymap.set('i', '<silent><expr> <Tab>', "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'" , {})
	
	
	-- vim.keymap.set('i', '<silent><expr> <C-E>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'" , {})
	-- " For changing choices in choiceNodes (not strictly necessary for a basic setup).
	-- vim.keymap.set('s', '<silent><expr> <C-E>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'" , {})
	
	require("luasnip.loaders.from_vscode").lazy_load() -- load friendly-snippets
	require("luasnip.loaders.from_vscode").load({  -- load custom code snip
		paths = {home.."/snippets"}
	})
	-- require('snippets.init')
end
return s;
