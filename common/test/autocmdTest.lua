package.path = package.path..';../?.lua';
local Autocmd = require('../autocmd');
local au = Autocmd.new('testGroup');
local action=function()
	print("InsertEnter called");
end
au:subscribe('InsertEnter',action);
