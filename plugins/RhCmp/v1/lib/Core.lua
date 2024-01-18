local Core={};

local AutoCmd= require('lib.AutoCmd');
local Highlight= require('lib.Highlight');

Core.new=function()
	local self=setmetatable({},{__index=Core});
	-- init fields of Core.
	self.autocmd=nil;
	self.highlight=nil;

	return self;
end

Core.setup=function(self)
	-- 1. create autocmd object and setup autocommands
	self.autocmd = AutoCmd.new();
	self.autocmd:setup();

	-- 2. create highlight object and setup different higlight
	-- TODO
end

return Core;
