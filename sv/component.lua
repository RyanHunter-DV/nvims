local tf=require('sv.method')
-- local debug=require('common.debug')
local component={}

component.getTfType = function(self,n)
	local tftype = 'function'
	if n == 'run' then
		tftype = 'task'
	end
	return tftype
end
-- component.phasePrototype = function(self,...)
-- 	local cnts = {}
-- 	tf:virtual()
-- 	--debug.log('phasePrototype called')
-- 	for _,pn in ipairs( ... ) do
-- 		local tftype = self.getTfType(pn)
-- 		--debug.log('component debug, pn:'..pn)
-- 		table.insert(cnts,tf:prototype(pn..'_phase','uvm_phase phase',tftype,'void'))
-- 	end
-- 	-- for _,v in ipairs(cnts) do
-- 	-- 	debug.log('component debug:')
-- 	-- 	debug.log(v)
-- 	-- end
-- 	return cnts
-- end
-- component.phaseBody = function(self,cn,...)
-- 	local cnts={}
-- 	for _,pn in ipairs( ... ) do
-- 		local tftype = self.getTfType(pn)
-- 		for _,l in ipairs(tf:body(cn..'::'..pn..'_phase','uvm_phase phase',tftype,'void')) do
-- 			table.insert(cnts,l)
-- 		end
-- 	end
-- 	return cnts
-- end

component.phase = function(self,cn,pn,exts)
	local phase = {}
	local cnts  = {}
	local tftype = self.getTfType(self,pn)
	phase.body  = {}
	phase.proto = {}
	table.insert(phase.proto,tf:prototype(pn..'_phase','uvm_phase phase',tftype,'void'))
	table.insert(cnts,'super.'..pn..'_phase(phase);')
	for _,ext in ipairs(exts) do
		table.insert(cnts,ext)
	end
	for _,b in ipairs(tf:body(cn,pn..'_phase','uvm_phase phase',tftype,'void',cnts)) do
		table.insert(phase.body,b)
	end
	return phase
end


return component
