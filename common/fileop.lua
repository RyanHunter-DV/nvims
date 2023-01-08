--local debug = require('common.debug')
local fileop = {}

-- fileop.createFileHeader = function(self)
-- 	local fname = vim.fn.bufname()
-- 	local macro = string.gsub(fname,'%.','__',1)
-- 	local cnts = {}
-- 	table.insert(cnts,'`ifndef '..macro)
-- 	table.insert(cnts,'`define '..macro)
-- 	table.insert(cnts,'`endif')
-- 	vim.api.nvim_buf_set_lines(0,0,-1,true,cnts)
-- end

fileop.insertContents = function(self,cnts,start)
	local cline = start
	for _,line in ipairs(cnts) do
		vim.fn.appendbufline(vim.fn.bufname(),cline,line)
		cline = cline+1
	end
end

return fileop
