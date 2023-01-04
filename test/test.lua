package.path = package.path..';/home/ryanhunter/GitHub/nvims/?.lua'
print("test autocmd")
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
require('rac.init')
