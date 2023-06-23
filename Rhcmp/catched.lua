local catched={};
local debug=require('common.debugMessagePrinter');debug.enable();

catched.new=function(self)
	local self=setmetatable({},{__index=catched});
	self.completions={};
	self.snippets={};
	self.pattern='';
	return self;
end

catched.setPattern=function(self,c)
	self.pattern=c;
end

-- add matched completion items into local table
-- the input completions are table like:
-- 'matched item' = 'source'
catched.addCompletions=function(self,completions,source)
	for _,c in ipairs(completions) do
		self.completions[c] = source;
	end
	return;
end
catched.clearCompletions=function(self)
	self.completions={};
end
catched.clearSnippets=function(self)
	self.snippets={};
end
catched.empty=function(self)
	local isEmpty = true;
	local csize = #vim.tbl_keys(self.completions);
	local ssize = #vim.tbl_keys(self.snippets);
	debug.d(string.format("size: %s, %s",csize,ssize));
	if csize>0 or ssize>0 then
		isEmpty=false;
	end
	return isEmpty;
end


return catched;
