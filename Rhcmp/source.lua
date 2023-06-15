local develop = true;
if develop then
	package.path = package.path .. ';/Users/huangqi/projectLocal/nvims/Rhcmp/?.lua';
end
local source={};
local debug=require('debugMessagePrinter');
local api = vim.api;
local grammer={};

debug.enable();
source.filetype = function()
	-- nvim cmd
	return api.nvim_buf_get_option(0,'filetype');
end

source.loadGrammers = function()
	ft = source.filetype();
	debug.d(string.format("filetype is : %s",ft));
	grammer = require(string.format('syntax/%s',ft));
end
source.loadSnippets = function()
	ft = source.filetype();
	snippets = require(string.format('snippets/%s',ft));
end


return source;
