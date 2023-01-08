local common = {}
local fo = require('common.fileop')
local str= require('common.stringop')

common.defmethod = function(self,n)
	local cnts = {}
	table.insert(cnts,'\tdef '..n..' ##{{{')
	--local matches = str:split(n)
	table.insert(cnts,'\tend ##}}}')
	local pos = vim.api.nvim_win_get_cursor(0)
	fo:insertContents(cnts,pos[1])
end

return common
