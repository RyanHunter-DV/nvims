local s={};

s.config={};
s.options={};
s.win = nil;
s.setupDefaultConfigs = function()
	s.config = {
		relative='cursor',
		-- relative='editor',
		row=2,col=0,
		width=19,
		height=6,
		border='rounded',
	};
	s.options = {
		number=false
	};
end
s.setupCompletionWindow = function()
	s.setupDefaultConfigs();
end
s.geometry = function(w,h)
	s.config.width = w;
	s.config.height= h;
end
s.width = function()
	return s.config.width;
end
s.open = function(buf)
	for k,v in pairs(s.config) do
		print(string.format("configs, %s -> %s",k,v));
	end
	s.win = vim.api.nvim_open_win(buf,false,s.config);
	for o,v in pairs(s.options) do
		vim.api.nvim_win_set_option(s.win,o,v);
	end
end

return s;
