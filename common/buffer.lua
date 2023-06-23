local buffer={};

buffer.new=function(self,scratch)
	local self=setmetatable({},{__index = buffer});
	scratch=(scratch==nil and true) or scratch;
	self:initialize(scratch);
	return self;
end
buffer.initialize=function(self,scratch)
	self.handle = vim.api.nvim_create_buf(false,scratch);
end
buffer.setOptions=function(self,pair)
	if self.handle==nil then
		return;
	end
	for o,v in pairs(pair) do
		o=tostring(o);
		vim.api.nvim_buf_set_option(self.handle,o,v);
	end
	return;
end
buffer.setlines=function(self,ctxs,sep)
	sep = (sep==nil and "\n") or sep;
	local newcontext = {};
	for _,line in ipairs(ctxs) do
		table.insert(newcontext,string.format("%s%s",line,sep));
	end
	vim.api.nvim_buf_set_lines(self.handle,0,0,false,newcontext);
end



return buffer;
