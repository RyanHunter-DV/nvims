local object={}

object.utils = function(self,cn)
	cnts = {}
	table.insert(cnts,'`uvm_object_utils_begin('..cn..')')
	table.insert(cnts,'`uvm_object_utils_end')
	return cnts
end
object.construct = function(self,cn)
	cnts = {}
	table.insert(cnts,'function new(string name="'..cn..'");')
	table.insert(cnts,'\tsuper.new(name);')
	table.insert(cnts,'endfunction')
	return cnts;
end
object.classblock = function(self,cn)
	local cnts = {}
	table.insert(cnts,'class ' .. cn .. ' extends uvm_object;')
	ncnts = self:utils(cn)
	for _,ncnt in ipairs(ncnts) do
		table.insert(cnts,'\t'..ncnt)
	end
	ncnts = self:construct(cn)
	for _,ncnt in ipairs(ncnts) do
		table.insert(cnts,'\t'..ncnt)
	end
	table.insert(cnts,'endclass')
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_buf_set_lines(0,pos[1],pos[1],true,cnts)
end
return object
