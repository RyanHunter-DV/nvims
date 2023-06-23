local keymap={};
local debug=require('common.debugMessagePrinter');debug.enable();

keymap.new=function(self)
	local self=setmetatable({},{__index=keymap});
	return self;
end
keymap.completionMapping=function(self,win)
	-- debug.d("not ready");
	local sn = 'RhcmpSelectNextCompletionItem';
	local sp = 'RhcmpSelectPrevCompletionItem';
	vim.api.nvim_buf_create_user_command(0,sn,function()
		win:selectNextItem('completion');
	end,{});
	vim.api.nvim_buf_create_user_command(0,sp,function()
		win:selectPrevItem('completion');
	end,{});
	vim.api.nvim_buf_set_keymap(0,'i','<c-n>','<Cmd>RhcmpSelectNextCompletionItem<CR>',{});
	vim.api.nvim_buf_set_keymap(0,'i','<c-p>','<Cmd>RhcmpSelectPrevCompletionItem<CR>',{});
end
keymap.reset=function(self)
end


return keymap;
