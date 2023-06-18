local window={};
local DEFAULT_HIGHLIGHT='Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None';

window.new=function(self)
	local self=setmetatable({},{__index=window});
	self:initialize();
	return self;
end

window.initialize=function(self)
	self.style={
		relative = 'win',style='minimal',
		-- anchor='',
		row=-1,col=-1,
		width=-1,height=-1,
		-- innerWidth=-1,innerHeight=-1,
		noautocmd=true,
		border='rounded',
		--title='none',
		-- title_pos='center',
		zindex=100
	};
	self.options={
		winhighlight = DEFAULT_HIGHLIGHT
	};
	self.scrollable=false;
	self.buffer=nil;
	self.win=nil;
end
window.title=function(self,t,pos)
	pos = (pos==nil and 'center') or pos;
	self.style.title=t;
	self.style.title_pos=pos;
end
window.geometry=function(self,width,height)
	self.style.width=width;
	self.style.height=height;
end
window.position=function(self,row,col)
	self.style.row=row;
	self.style.col=col;
end
-- open a window
window.open=function(self,buf)
	self.buffer=buf;
	self.win = vim.api.nvim_open_win(self.buffer,false,self.style);
	for k,v in pairs(self.options) do
		-- print(string.format("%s -> %s",k,v));
		vim.api.nvim_win_set_option(self.win,k,v);
	end
end

-- close this window
window.close=function(self)
	if (self.win and vim.api.nvim_win_is_valid(self.win)) then
		vim.api.nvim_win_hide(self.win);
		self.win=nil;
	end
end
window.visible = function(self)
	return self.win and vim.api.nvim_win_is_valid(self.win)
end
window.setOption=function(self,o,v)
end
window.getConfig = function(self,name,value)
end
window.updateConfig=function(self,c)
	vim.api.nvim_win_set_config(self.win,c);
	-- local c=vim.api.nvim_win_get_config(self.win);
	-- if (vim.tbl_contains(c,name)) then
	-- 	c.name=value;
	-- end
end
-- update config and reopen the window
window.refresh=function(self,c)
	self:close();
	self.style = vim.tbl_extend('keep',c,self.style);
	self:open(self.buffer);
end

return window;
