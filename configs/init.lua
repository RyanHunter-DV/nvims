local path=debug.getinfo(1).source;
local l=string.len(path);
local home =string.sub(path,2,l-string.len('/configs/init.lua'));
package.path=package.path..string.format(";%s/configs/?.lua",home);

local config={};

config.basicVimSettings = function()
	vim.wo.cursorline = true
	vim.wo.number     = true
	vim.o.ts          = 4
	vim.o.shiftwidth  = 4
	vim.o.incsearch   = true
	vim.o.hlsearch    = true
	vim.o.cindent     = true
	-- set for default gui font
	vim.o.guifont="JetBrains Mono:h12"
	
	vim.cmd ([[ set foldmethod=marker ]])
	if vim.g.neovide==true then
		vim.cmd ([[ set mouse=na ]])
	else
		vim.cmd ([[ set mouse= ]])
	end
	-- vim.cmd([[ set nowrap ]])
	vim.cmd([[ set foldmarker=##{{{,##}}} ]])
	vim.cmd([[au BufRead,BufNewFile *.rh set filetype=ruby]])
	vim.cmd([[au BufRead,BufNewFile *.svh.src,*.sv.src set filetype=ruby]])
	-- TODO, vim.cmd([[au FileType ruby setlocal shiftwidth=4 ]])
	vim.cmd([[au FileType * setlocal fo-=o ]])
	vim.cmd([[au FileType * set softtabstop=0 ]])
	vim.cmd([[au FileType * set noexpandtab ]])
	vim.cmd([[au FileType * set shiftwidth=4 ]])
	-- TODO, vim.cmd([[au FileType systemverilog lua require('sv.init') ]])
	-- TODO, vim.cmd([[au FileType ruby lua require('ruby.init') ]])
	vim.cmd ([[au BufRead,BufNewFile *.svh set filetype=systemverilog]])
	vim.cmd ([[set guicursor=n-v-c-a-sm:blinkon200,i-ci-ve:ver25,r-cr-o:hor20]])
end

config.default = function()
	config.basicVimSettings();
	-- require('plugin')
	require('plugin').setup(home);
end

config.setup = function(m)
	if m=='default' then
		config.default();
	end
end


return config;
