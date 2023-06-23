local s={};

s.config={};
s.window=nil;

s.createCompletionBuffer = function()
	-- 1 -> completion buffer
	-- 2 -> snippets preview buffer
	local num=2;
	for i=1,num,1 do
		table.insert(s.config.buffer,vim.api.nvim_create_buf(false,true));
	end
end
s.setupDefaultConfigs = function()
	s.config = {
		buffer = {},
	};
end
s.setup = function(w)
	s.setupDefaultConfigs();
	s.createCompletionBuffer();
	s.window = w;
end


s.getMaxLen = function(sources)
	local l=0;
	for ctx,src in pairs(sources) do
		if l<string.len(ctx..src) then
			l = string.len(ctx..src);
		end
	end
	return l;
end
s.getMaxRow = function(sources)
	local l=1;
	for ctx,_ in pairs(sources) do
		l=l+1;
	end
	return l;
end

-- This api to get matched sources, and arrange the context.
-- sources => table, like: {'context'=>'source','aaaa'=>'grammer'}
s.fillSources = function(target,sources)
	local width = s.getMaxLen(sources) + 10;
	local height= s.getMaxRow(sources) + 2;
	s.window.geometry(width,height);
	s.render(target,sources);
end

s.format = function(purpose,ctx,src,len)
	local f='';
	len=len-3; -- shall reduce the len of the heading flag
	if purpose == 'suggestion' then
		sstart = len-string.len(src)-2-1;
		f = '- '..ctx;
		for i=1,len-2-string.len(ctx..src) do
			f = f..' ';
		end
		f = f..'['..src..']';
	else
		-- TODO
	end
	print(string.format("getting format: %s",f));
	return f;
end
s.highlights = function(sources)
	-- TODO
end
s.display = function(purpose,e,context)
	local index = 1;
	if purpose ~= 'suggestion' then
		index = 2;
	end
	print (s.config.buffer[index]);
	print (context);
	vim.api.nvim_buf_set_lines(s.config.buffer[index],0,e,false,context);
	s.window.open(s.config.buffer[index]);
end
s.renderSugguestion = function(sources)
	local maxlen = s.window.width();
	local formatted = {};
	local nums = 1;
	for ctx,src in pairs(sources) do
		table.insert(formatted,s.format('suggestion',ctx,src,maxlen));
		nums = nums+1;
	end
	-- ctxt    [src]
	-- ctx    [src2]
	-- ...
	-- TODO, s.highlights(sources);
	s.display('suggestion',nums-1,formatted);
end

s.renderPreview = function()
	-- TODO
end

s.render = function(target,sources)
	if target=='preview' then
		s.renderPreview(sources);
	else
		s.renderSugguestion(sources);
	end
end

return s;
