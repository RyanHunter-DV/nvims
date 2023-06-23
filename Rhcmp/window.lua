local window={};
local debug=require('common.debugMessagePrinter');

window.new=function(self)
	local self=setmetatable({},{__index=window});

	return self;
end

window.render=function(self,catches,callback)
	debug.d("render not ready");
end


return window;
