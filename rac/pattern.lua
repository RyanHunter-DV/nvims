local debug=require('common.debug')
local pattern = {}
pattern.cword = ''

pattern.new = function(self)
	self.cword = ''
	debug.log('pattern.new, cword: '..self.cword)
	return self
end

-- return true if oneword pattern only has 1 character
pattern.onecharPattern = function(self)
	debug.log("call onecharPattern, cword: "..self.cword)
	if self.cword==nil then
		return true
	end
	debug.log("call onecharPattern, cword: "..self.cword)
	debug.log("cword len: "..string.len(self.cword))
	if string.len(self.cword)<=1 then
		return true
	else
		return false
	end
end

pattern.split = function(self,s)
	local sep = ' '
	local matches = {}
	debug.log("split, source: "..s)
	matches = vim.split(s,sep)
	for i,v in ipairs(matches) do
		if v=='' then
			table.remove(matches,i)
		end
	end
	return matches
end

pattern.len = function(self,a)
	local l=0
	for i,v in ipairs(a) do
		debug.log("len, index "..i..", value: "..v)
		l = l+1
	end
	return l
end

-- to strip all space chars
pattern.stripSpaces = function(self,s)
	local processed = ''
	if string.find(s,"[%S]")~=nil then
		processed = string.gsub(s,'\t',' ')
		processed = string.gsub(processed,"%(",' ')
		processed = string.gsub(processed,"%)",' ')
		processed = string.gsub(processed,"%[",' ')
		processed = string.gsub(processed,"%]",' ')
		processed = string.gsub(processed,"\"",' ')
		processed = string.gsub(processed,"'",' ')
		processed = string.gsub(processed,"%%",' ')
	end
	while string.sub(processed,1,1)==' ' do
		processed = string.sub(processed,2)
	end
	debug.log('stripSpaces: '..processed)
	return processed
end

-- process the current line user is typing
pattern.processSource = function(self,line)
	debug.log("line info: "..line)
	line = self:stripSpaces(line)
	local words = self.split(self,line)
	local len = self.len(self,words)
	debug.log("processSource, len: "..len)
	-- debug.log("processSource, word[0]: "..words[0])
	if len>0 then
		-- the index in words starts from 1
		self.cword = words[len]
	else
		self.cword = ''
	end
	return
end

-- return the last word user's typing
pattern.oneword = function(self)
	return self.cword
end

pattern.matchSource = function(self,p,line)
	line = self:stripSpaces(line)
	local md = string.match(line,'('..p..'%S+)')
	return md
end

return pattern
