local context={};
local utils=require('Rhcmp.utils');
local debug=require('common.debugMessagePrinter');debug.enable();

context.new=function(self)
	local self=setmetatable({},{__index=context});

	self:initialize();

	return self;
end
context.initialize=function(self)
	self.lineContext='';
	self.changed=false;
end

context.update=function(self,ctx)
	self.lineContext=ctx;
	self.changed=false;
end
-- if changed, then return true, else return false
context.isChanged=function(self)
	if self.changed then
		-- text changed been called and not updated, then return true directly
		return true,self.lineContext;
	end
	local current=vim.api.nvim_get_current_line();
	if self.lineContext~=current then
		self.changed=true;
		debug.d(string.format("context changed to: %s",current));
		return true,current;
	else
		return false,'';
	end
	return false,'';
end

-- return the current context line string before current cursor.
context.lineBeforeCursor=function(self)
	local row,col = utils.getCurrentCursorPosition();
	return string.sub(self.lineContext,1,col+1);
end
context.reset=function(self)
	self:initialize();
end


return context;
