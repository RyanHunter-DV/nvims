local window={};
local debug=require('common.debugMessagePrinter');

window.new=function(self)
	local self=setmetatable({},{__index=window});
	self.opened=false;
	self.configs = {completion={},snippet={}};
	self.options = {completion={},snippet={}};
	self.buffers = {completion=nil,snippet=nil};
	self.winHandles={completion=nil,snippet=nil};
	self.configs.completion = {
		relative='cursor',
		row=1,col=0,
		width =1,height=1,
		border='rounded',
	};
	self.options.completion = {number=false};
	return self;
end

window.render=function(self,catches,callback)
	debug.d("render not ready");
	if self.opened then
		self:redraw(catches);
	else
		self:draw(catches);
	end
	callback(); -- TODO
end
window.formatCatches=function(self,catches)
	local items={};
	local maxlen=0;
	for c,_ in pairs(catches.completions) do
		if maxlen < string.len(c) then
			maxlen=string.len(c);
		end
	end
	maxlen = maxlen + 10;
	for c,s in pairs(catches.completions) do
		local item = '- '..c;
		while (string.len(item)<maxlen) do
			item=item..' ';
		end
		item=item..'['..s..']';
		table.insert(items,item);
	end
	return items;
end
window.draw=function(self,catches)
	local formatted = self:formatCatches(catches);
	self:drawCompletionWindow(formatted);
	--TODO
end
window.updateCompletionWindowConfigs=function(self,width,num)
	self.configs['completion'].width = width;
	local height = vim.api.nvim_win_get_height(0);
	if num >= height then
		self.configs['completion'].height= tonumber(height*0.7);
	else
		self.configs['completion'].height= num;
	end
end
window.drawCompletionWindow=function(self,items)
	if #items==0 then
		return;
	end
	local num  = #items;
	local width= string.len(items[1]);
	self:updateCompletionWindowConfigs(width,num);
	self:openCompletionWindow();
	for _,l in ipairs(items) do
		debug.d(string.format("items -> %s",l));
	end
	self:fillItems(self.buffers['completion'],items);
end
window.fillItems=function(self,buf,items)
	vim.api.nvim_buf_set_lines(buf,0,#items,false,items);
	--TODO
end

window.redraw=function(self,catches)
	debug.d("redraw not ready");
end
window.openCompletionWindow=function(self)
	local buf = vim.api.nvim_create_buf(false,true);
	local config =self.configs['completion'];
	local options=self.options['completion'];
	local win = vim.api.nvim_open_win(buf,false,config);
	self.winHandles['completion'] = win;
	self.buffers['completion'] = buf;
	self.opened=true;
	for o,v in pairs(options) do
		vim.api.nvim_win_set_option(win,o,v);
	end
end


return window;
