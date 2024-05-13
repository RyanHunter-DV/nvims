--package.path = package.path..';/home/ryanhunter/GitHub/nvims/?.lua'
--print("test starts")
-- vim.o.completeopt='menu,menuone,noinsert'
-- local ac = require('common/autocmd')
-- local onTextChanged = function()
-- 	local offset = 3
-- 	local items = {'one','tow'}
-- 	vim.fn.complete(offset,items)
-- end
-- ac.subscribe("TextChangedI",onTextChanged)

-- require('auc.init')
-- require('sv.init')
-- w = require('Rhcmp.window')
-- c = require('Rhcmp.context')
-- w.setupCompletionWindow();
-- c.setup(w);
-- t={
-- 	textinfo='souruce0',
-- 	textinfo1='source1',
-- 	virtual='source1',
-- };
-- c.fillSources('suggestion',t);

-- print(string.byte(''));
--print(string.format("%s",238));

--vim.api.nvim_buf_set_option(0,'mouse'='n');
-- local t = vim.api.nvim_get_all_options_info();
-- local ls={};
-- for k,v in pairs(t['mouse']) do
-- 	table.insert(ls,string.format("%s->%s",k,v));
-- end
-- vim.api.nvim_buf_set_lines(0,1,-1,false,ls);

-- vim.api.nvim_buf_set_option(0,'mouse','n');

--vim.api.nvim_set_option('mouse','');
--

print(vim.inspect(_G))
