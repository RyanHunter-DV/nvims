local method = {}

method.isVirtual = false
method.virtual = function(self)
	self.isVirtual = true
end
method.prototype = function(self,n,arg,t,rtn)
	local p = '\textern '
	if self.isVirtual then
		p = p..'virtual '
	end
	p = p..t
	if t=='function' then
		p = p..' '..rtn
	end
	p = p..' '..n..' ('..arg..');'
	return p
end
method.body = function(self,cn,mn,arg,t,rtn,block)
	local cnts = {}
	local tf = t
	if t=='function' then
		tf = tf..' '..rtn
	end
	local fullmethod = cn..'::'..mn
	table.insert(cnts,tf..' '..fullmethod..'('..arg..');')
	for _,b in ipairs(block) do
		table.insert(cnts,'\t'..b)
	end
	table.insert(cnts,'end'..t)
	return cnts
end



return method
