package.path = package.path..';../?.lua';
local Window=require('window');
local buf = vim.api.nvim_create_buf(false,true);
local win = Window.new();
local win2 = Window.new();
win:geometry(30,20);
win:position(10,2);
win:title('hello');
win:open(buf);
win2:geometry(30,20);
win2:position(10,34);
win2:open(buf);

r=function()
	win:refresh({row=8,col=10});
end
--win:updateConfig({row=8,col=10});
-- dt=function(t)
-- 	--io.write('{');
-- 	for k,v in pairs(t) do
-- 		if type(v)=='table' then
-- 			dt(v);
-- 		end
-- 		print(string.format("%s -> %s",k,v));
-- 	end
-- 	--io.write("}\n");
-- end
-- local c = vim.api.nvim_win_get_config(win.win);
-- local line=1;
-- dt(c);

--vim.api.nvim_win_set_option(win.win,'winhighlight', 'EndOfBuffer:PmenuSbar,NormalFloat:PmenuSbar');
-- vim.api.nvim_win_set_option(win.win,'winhighlight', 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None');


-- win:close(buf);
return r;
