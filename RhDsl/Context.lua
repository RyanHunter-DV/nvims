local Context={};

function Context:new()
	local self=setmetatable({},{__index=Context});

	return self;
end


return Context;
