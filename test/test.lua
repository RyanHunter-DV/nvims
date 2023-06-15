package.path = package.path..';/home/ryanhunter/GitHub/nvims/?.lua'
print("test starts")
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
w = require('Rhcmp.window')
c = require('Rhcmp.context')
w.setupCompletionWindow();
c.setup(w);
t={
	textinfo='souruce0',
	textinfo1='source1'
};
c.fillSources('suggestion',t);
