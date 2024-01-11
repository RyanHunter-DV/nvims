-- local debug= require('common.debug')
local comp = require('sv.component')
local driver = {}

driver.classblock = function(self,cn)
	local cnts = {}
	table.insert(cnts,'class '..cn..' #(type REQ=uvm_sequence_item,RSP=REQ) extends uvm_driver#(REQ,RSP);')
	table.insert(cnts,'\t`uvm_component_utils('..cn..'#(REQ,RSP))')
	-- table.insert(cnts,comp:utils(cn))
	-- table.insert(cnts,comp:new(cn))
	-- table.insert(cnts,comp:phases(cn))
	table.insert(cnts,'\tfunction new(string name="'..cn..'",uvm_component parent=null);')
	table.insert(cnts,'\t\tsuper.new(name,parent);')
	table.insert(cnts,'\tendfunction')
	-- for _,v in ipairs(comp:phasePrototype({'build','connect','run'})) do
	-- 	table.insert(cnts,v)
	-- end
	local build  = comp:phase(cn,'build',{})
	local connect= comp:phase(cn,'connect',{})
	local run    = comp:phase(cn,'run',{})
	for _,v in ipairs(build.proto) do
		table.insert(cnts,v)
	end
	for _,v in ipairs(connect.proto) do
		table.insert(cnts,v)
	end
	for _,v in ipairs(run.proto) do
		table.insert(cnts,v)
	end
	table.insert(cnts,'endclass')
	table.insert(cnts,'')
	table.insert(cnts,'')
	table.insert(cnts,'//-----------------------CLASS BODY-----------------------//')
	table.insert(cnts,'')

	for _,v in ipairs(build.body) do
		table.insert(cnts,v)
	end
	for _,v in ipairs(connect.body) do
		table.insert(cnts,v)
	end
	for _,v in ipairs(run.body) do
		table.insert(cnts,v)
	end
	-- for _,v in ipairs(comp:phaseBody(cn,{'build','connect','run'})) do
	-- 	table.insert(cnts,v)
	-- end
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_buf_set_lines(0,pos[1],pos[1],true,cnts)
	--for _,v in ipairs(cnts) do
	--	-- debug.log(v)
	--end
	-- TODO
end


return driver
