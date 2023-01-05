local pacakge = {}
local fo = require('sv.fileop')

-- this will create a package start/end declaration
package.createPackage = function(self,pn)
	print("[DEBUG] get package name: "..pn)
	local cnts = {}
	table.insert(cnts,'`include "uvm_macros.svh"')
	table.insert(cnts,'package '..pn..';')
	table.insert(cnts,'\timport uvm_pkg::*;')
	table.insert(cnts,'endpackage')
	local pos = vim.api.nvim_win_get_cursor(0)
	fo:insertContents(cnts,pos[1])
	-- vim.api.nvim_buf_set_lines(-1,0,-1,true,cnts)
end

return package
