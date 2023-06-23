package.path = package.path..';../?.lua';
local Buffer=require('buffer');
local Window=require('window');
local win = Window.new();
local buf = Buffer.new();
local options= {
	modifiable=true
}
buf:setOptions(options);
win:geometry(50,1);
win:position(1,2);
win:focus(true);
win:open(buf.handle);
--buf:setlines({'>> '},'');
--vim.cmd[[startinsert]];
--local h=vim.api.nvim_win_get_height(0);
--local w=vim.api.nvim_win_get_width(0);
--print(string.format("%0dx%0d",w,h));
