local debug=require('common.debugMessagePrinter');debug.enable();
local am = {}; -- autocmd manager
local Autocmd=require('common.autocmd');

am.new=function(self)
	local self=setmetatable({},{__index=am});
	self.au = Autocmd.new('__Rhcmp__');
	return self;
end

am.setupTextChangedAutoCmd= function(self,action)
	self.au:subscribe({'TextChangedI','TextChangedP'},action);
end

return am;
