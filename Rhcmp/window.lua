local window={};
local debug=require('common.debugMessagePrinter');

window.new=function(self)
	local self=setmetatable({},{__index=window});
	self.opened= {completion=false,snippet=false};
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
	self.cursorline = {completion=1,snippet=1};
	self.itemnums = {completion=0,snippet=0};
	self:reset('completion');
	return self;
end
window.reset=function(self,t)
	self.options[t]= self:initWindowOptions(t);
	self.itemnums[t]=0;
	self.cursorline[t]=1;
end
window.initWindowOptions=function(self,t)
	local options = {
		winhighlight='Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
		wrap=false,
		scrolloff=0,
		sidescrolloff=0,
		number=false
	};
	return options;
end

window.render=function(self,catches,callback)
	-- debug.d("render not ready");
	if self.opened['completion'] then
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
	-- highlights
end
window.updateCompletionWindowConfigs=function(self,width,num)
	self.configs['completion'].width = width;
	local height = vim.api.nvim_win_get_height(0);
	if num >= height then
		self.configs['completion'].height= tonumber(height*0.7);
	else
		self.configs['completion'].height= num;
	end
	self.itemnums['completion'] = num;
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
window.selectNextItem=function(self,t)
	local nextIndex = self.cursorline[t] + 1;
	if nextIndex > self.itemnums[t] then
		nextIndex = 1;
	end
	vim.api.nvim_win_set_cursor(self.winHandles[t],{nextIndex,0});
	self.cursorline[t] = nextIndex;
end
window.selectPrevItem=function(self,t)
	local prevIndex = self.cursorline[t] - 1;
	if prevIndex < 1 then
		prevIndex = self.itemnums[t];
	end
	vim.api.nvim_win_set_cursor(self.winHandles[t],{prevIndex,0});
	self.cursorline[t] = prevIndex;
end

window.redraw=function(self,catches)
	local win = self.winHandles['completion'];
	vim.api.nvim_win_hide(win);
	self.winHandles['completion']=nil;
	self:draw(catches);
end
window.getBuffer=function(self,t)
	if self.buffers[t] ~= nil then
		return self.buffers[t];
	else
		local buf = vim.api.nvim_create_buf(false,true);
		self.buffers[t]=buf;
		return buf;
	end
end
window.openCompletionWindow=function(self)
	local buf = self:getBuffer('completion');
	local config =self.configs['completion'];
	local options=self.options['completion'];
	local win = vim.api.nvim_open_win(buf,false,config);
	self.winHandles['completion'] = win;
	self.opened.completion=true;
	for o,v in pairs(options) do
		vim.api.nvim_win_set_option(win,o,v);
	end
end
window.close=function(self)
	self:closeCompletionWindow();
	self:closeWindowOptions('completion');
	-- TODO self:closeSnippetWindow();
end
window.closeWindowOptions=function(self,t)
	self.options[t]=self:initWindowOptions(t);
	self.cursorline[t] = 1;
end
window.closeCompletionWindow=function(self)
	if self.opened.completion then
		self.opened.completion=false;
		vim.api.nvim_win_hide(self.winHandles['completion']);
		vim.api.nvim_buf_delete(self.buffers['completion'],{force=true});
		self.winHandles['completion']=nil;
		self.buffers['completion']=nil;
	end
	self:reset('completion');
	return;
end


return window;
