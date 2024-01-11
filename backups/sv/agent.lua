
local comp = require('sv.component')
local agent = {}

agent.classblock = function(self,preCn)
	local cnts = {}
	local cn  = preCn..'Agent';
	local drv = preCn..'Driver#(REQ,RSP)';
	local mon = preCn..'Monitor#(REQ,RSP)';
	local seqr= preCn..'Seqr#(REQ,RSP)';
	table.insert(cnts,'class '..cn..' extends uvm_agent;')
	table.insert(cnts,'\tparameter REQ=<SPECIFIC_REQ_TRANS>;')
	table.insert(cnts,'\tparameter RSP=<SPECIFIC_RSP_TRANS>;')
	table.insert(cnts,'\t'..drv..' drv;')
	table.insert(cnts,'\t'..mon..' mon;')
	table.insert(cnts,'\t'..seqr..' seqr;')
	table.insert(cnts,'\t`uvm_component_utils_begin('..cn..')')
	table.insert(cnts,'\t\t`uvm_field_object(drv,UVM_ALL_ON)')
	table.insert(cnts,'\t\t`uvm_field_object(mon,UVM_ALL_ON)')
	table.insert(cnts,'\t\t`uvm_field_object(seqr,UVM_ALL_ON)')
	table.insert(cnts,'\t`uvm_component_utils_end')
	-- table.insert(cnts,comp:utils(cn))
	-- table.insert(cnts,comp:new(cn))
	-- table.insert(cnts,comp:phases(cn))
	table.insert(cnts,'\tfunction new(string name="'..cn..'",uvm_component parent=null);')
	table.insert(cnts,'\t\tsuper.new(name,parent);')
	table.insert(cnts,'\tendfunction')
	-- for _,v in ipairs(comp:phasePrototype({'build','connect','run'})) do
	-- 	table.insert(cnts,v)
	-- end
	local buildactions = {}
	table.insert(buildactions,'if (is_active==UVM_ACTIVE) begin')
	table.insert(buildactions,'\tdrv = '..drv..'::type_id::create("drv",this);')
	table.insert(buildactions,'\tseqr = '..seqr..'::type_id::create("seqr",this);')
	table.insert(buildactions,'end')
	table.insert(buildactions,'mon = '..mon..'::type_id::create("mon",this);')
	local connectactions = {}
	table.insert(connectactions,'if (is_active==UVM_ACTIVE) begin')
	table.insert(connectactions,'\tdrv.seq_item_port.connect(seqr.seq_item_export);')
	table.insert(connectactions,'end')
	local build  = comp:phase(cn,'build',buildactions)
	local connect= comp:phase(cn,'connect',connectactions)
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


return agent
