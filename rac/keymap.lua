
local keymap = {}

keymap.new = function(self)
	return keymap
end
keymap.chooseMap = function(self,index)
	local m = ''
	m = '<Cmd>lua vim.api.nvim_select_popupmenu_item(vim.fn.complete_info({"selected"}).selected,true,true,{})<CR>'
	m = m..'<ESC>a'
	return m
end
keymap.switchMap = function(self)
	local m = ''
	m = '<C-N>'
	return m
end

keymap.keymapWhenCompletionOn = function(self,index)
	-- <CR> for choosing
	-- <TAB> for selection switch
	local choosemap = self:chooseMap(index)
	local switchmap = self:switchMap()
	vim.api.nvim_buf_set_keymap(0,'i','<CR>',choosemap,{noremap=true})
	vim.api.nvim_buf_set_keymap(0,'i','<TAB>',switchmap,{noremap=true})
end

keymap.clearmap = function(self)
	vim.api.nvim_buf_del_keymap(0,'i','<CR>')
	vim.api.nvim_buf_del_keymap(0,'i','<TAB>')
	return
end


return keymap
