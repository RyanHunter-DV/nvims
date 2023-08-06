local core={};
local debug=require('common.debugMessagePrinter');debug.enable();
local ui=require('RhDsl.config'):new();
local au=require('RhDsl.AutoCmds'):new();

core.setup = function(userConfigs);
	ui:setupConfigs(userConfigs);
	au:setupAutoCmds(ui);
end


return core;
