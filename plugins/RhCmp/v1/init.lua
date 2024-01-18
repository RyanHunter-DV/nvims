local M={};
local core={};

M.setup=function(home)
	-- add search path for libs of this plugin.
	package.path=package.path..string.format(";%s/plugins/RhCmp/v1/?.lua",home);

	require('lib.Core');
	-- 1. build a new core
	core = Core.new();
	-- 2. core:setup
	core:setup();
end




return M;
