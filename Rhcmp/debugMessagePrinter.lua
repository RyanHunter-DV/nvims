local debug={};
local isDebugMode=false;

debug.enable = function()
	isDebugMode=true;
end

debug.d = function(msg)
	if (isDebugMode) then
		print(msg);
	end
end


return debug;
