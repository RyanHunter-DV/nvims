local AutoCmd={};

AutoCmd.new=function()
	local self = setmetatable({},{__index=AutoCmd});
	-- TODO, MARKER
	return self;
end

AutoCmd.setup=function(self)
end


return AutoCmd;
