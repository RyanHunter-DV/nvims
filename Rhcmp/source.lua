-- local develop = true;
-- if develop then
-- 	package.path = package.path .. ';/Users/huangqi/projectLocal/nvims/Rhcmp/?.lua';
-- end
local debug=require('common.debugMessagePrinter');debug.enable();
local api = vim.api;
local syntax={};
local source={};
local Catched=require('Rhcmp.catched');


source.new=function(self)
	local self=setmetatable({},{__index=source});
	return self;
end

source.filetype = function()
	-- nvim cmd
	return api.nvim_buf_get_option(0,'filetype');
end

source.loadSyntax= function(self)
	ft = source.filetype();
	debug.d(string.format("filetype is : %s",ft));
	syntax= require(string.format('Rhcmp.syntax.%s',ft));
end
source.loadSnippets = function(self)
	ft = source.filetype();
	-- TODO, snippets = require(string.format('Rhcmp.snippets.%s',ft));
end

-- function called by autocmd when text changed, this API will help to
-- search the completions and snippets that matches the given context.
-- and return a table object that contains all catched sources.
source.research=function(self,context)
	--self:clear();
	debug.d(string.format("line before cursor:%s",context:lineBeforeCursor()));
	local catch = Catched.new();
	local pattern = vim.regex(string.format("^%s",context:lineBeforeCursor()));
	catch:addCompletions(syntax.searchBuiltins(pattern),'syntax');
	-- catch:addCompletions(syntax.searchLocalBuffer(pattern));
	-- catch:addSnippets(xxx);
	return catch;
	-- return nil; -- TODO
end

-- this been called by the Rhcmp.core when user setup this plugin, in source, which
-- will preload the syntax and snippets from certain files.
source.setup=function(self)
	self:loadSyntax();
	self:loadSnippets();
end

return source;
