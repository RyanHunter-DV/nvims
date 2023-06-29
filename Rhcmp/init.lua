local rhcmp={};

local libdir = vim.loop.fs_realpath('..');
-- print(libdir);
package.path = package.path..string.format("%s/?.lua",libdir);

local debug=require('common.debugMessagePrinter');debug.enable();
-- Window = require('common/window');
local Core=require('Rhcmp.core');

rhcmp.setup = function(configs)
	-- TODO, no configs yet.
	local core = Core:new();
	core:start();
end


return rhcmp;
