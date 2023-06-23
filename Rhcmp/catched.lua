local catched={};

catched.new=function(self)
	local self=setmetatable({},{__index=catched});
	self.completions={};
	self.snippets={};
	return self;
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


return catched;
