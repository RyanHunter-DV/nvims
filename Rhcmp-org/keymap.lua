local keymap={};
local debug=require('common.debugMessagePrinter');debug.enable();

local maps={
	selectNextItem = '<c-n>',
	selectPrevItem = '<c-p>',
	chooseItem = '<Tab>',
};
keymap.new=function(self)
	local self=setmetatable({},{__index=keymap});
	return self;
end
keymap.completionMapping=function(self,core)
	-- debug.d("not ready");
	local sn = 'RhcmpSelectNextCompletionItem';
	local sp = 'RhcmpSelectPrevCompletionItem';
	local c  = 'RhcmpChooseItem';
	vim.api.nvim_buf_create_user_command(0,sn,function()
		core:selectNextItem('completion');
	end,{});
	vim.api.nvim_buf_create_user_command(0,sp,function()
		core:selectPrevItem('completion');
	end,{});
	vim.api.nvim_buf_create_user_command(0,c,function()
		core:chooseItem('completion');
	end,{});
	vim.api.nvim_buf_set_keymap(0,'i',maps.selectNextItem,'<Cmd>RhcmpSelectNextCompletionItem<CR>',{});
	vim.api.nvim_buf_set_keymap(0,'i',maps.selectPrevItem,'<Cmd>RhcmpSelectPrevCompletionItem<CR>',{});
	vim.api.nvim_buf_set_keymap(0,'i',maps.chooseItem,'<Cmd>RhcmpChooseItem<CR>',{});
end
keymap.reset=function(self)
	for _,lhs in pairs(maps) do
		vim.api.nvim_buf_del_keymap(0,'i',lhs);
	end
end

---Shortcut for nvim_replace_termcodes
---@param keys string
---@return string
keymap.t = function(keys)
  return (string.gsub(keys, '(<[A-Za-z0-9\\%-%[%]%^@]->)', function(match)
    return vim.api.nvim_eval(string.format([["\%s"]], match))
  end))
end
---Create backspace keys.
---@param count string|integer
---@return string
keymap.backspace = function(count)
  if type(count) == 'string' then
    count = vim.fn.strchars(count, true)
  end
  if count <= 0 then
    return ''
  end
  local keys = {}
  table.insert(keys, keymap.t(string.rep('<BS>', count)))
  return table.concat(keys, '')
end

return keymap;
