-- This file used to translate nvim apis into local common apis for Rhcmp
local utils={};

local debug=require('common.debugMessagePrinter');debug.enable();

-- To get current cursor position with row,col separated items
utils.getCurrentCursorPosition=function()
	local tup = vim.api.nvim_win_get_cursor(0);
	debug.d(string.format("%d, %d",tup[1],tup[2]));
	return tup[1],tup[2];
end



return utils;
