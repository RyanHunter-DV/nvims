local keymap={};
local debug=require('common.debugMessagePrinter');debug.enable();

keymap.new=function(self)
	local self=setmetatable({},{__index=keymap});
	return self;
end
keymap.completionMapping=function(self)
	debug.d("not ready");
end


return keymap;
