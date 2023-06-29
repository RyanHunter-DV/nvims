local S={};
local debug=require('common.debugMessagePrinter');debug.enable();
local SupplimentLength=10;

function S:new(t,c)
	local self=setmetatable({},{__index=S});
	self.content=c;
	self.tag=t;

	return self;
end


function S:length()
	return string.len(self.content..self.tag)+SupplimentLength;
end

function S:formatted(prefix,max)
	local c = self.content;
	local t = self.tag;
	local sup = string.rep(' ',max-string.len(c..t..prefix..'[]'));
	local line = prefix..c..sup..'['..t..']';
	return line;
end



return S;
