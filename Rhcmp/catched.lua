local catched={};
local debug=require('common.debugMessagePrinter');debug.enable();

catched.new=function()
	local self=setmetatable({},{__index=catched});
	self.completions={
		syntax={},
	};
	self.snippets={};
	self.pattern={
		word='',
		match=''
	};
	return self;
end

catched.filterWord=function(self,l)
	local maxlen=string.len(l);
	local pos=maxlen;
	while (string.sub(l,pos,pos)~=' ') do
		pos = pos-1;
		if pos<1 then
			break;
		end
	end
	if pos<1 then
		return l;
	end
	return string.sub(l,pos+1,maxlen);
end
catched.setPattern=function(self,c)
	self.pattern.match=c;
	self.pattern.word=self:filterWord(c);
end

-- add matched completion items into local table
-- the input completions are table like:
-- 'matched item' = 'source'
catched.addCompletions=function(self,completions,tag)
	for _,c in ipairs(completions) do
		table.insert(self.completions[tag],c);
		-- self.completions[c] = source;
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
