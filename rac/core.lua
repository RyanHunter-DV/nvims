local core = {}
local ptrn = require('rac.pattern')
local kmap = require('rac.keymap')
local debug= require('common.debug')
local isbusy=false

core.init = function(self)
	-- clear all buffered information
	debug.log("core.init called")
	self.ptrn  = ptrn:new()
	self.kmap  = kmap:new()
	self.isbusy= true
	self.pos  = vim.api.nvim_win_get_cursor(0)
	debug.log('cword: '..self.ptrn.cword)
	self.matched = {}
end

core.busy = function(self)
	return self.isbusy
end
-- processPattern returns 1, then the length of
-- the pattern only contains one character, the caller should return immediatedly
core.processPattern = function(self,line)
	debug.log("get line: "..line)
	self.pos = vim.api.nvim_win_get_cursor(0)
	self.ptrn:processSource(line)
	if self.ptrn:onecharPattern() then
		return true
	else
		debug.log("get false of onecharPattern")
		return false
	end
end

-- comparing the words in contents with the pattern
core.matchPattern = function(self,p,cnts)
	local matches = {}
	debug.log("call matchPattern")
	debug.log("pattern: "..p)
	for _,v in ipairs(cnts) do
		debug.log('src: '..v)
	end
	for _,line in ipairs(cnts) do
		md = self.ptrn:matchSource(p,line)
		if md ~= nil then
			table.insert(matches,md)
		end
	end
	return matches
end

-- filter all matched words in current buffer
core.loadBufferContext = function(self)
	debug.log("loadBufferContext start")
	local cnts = vim.api.nvim_buf_get_lines(0,0,-1,true)
	local matchedContext = self:matchPattern(self.ptrn:oneword(),cnts)
	for _,v in ipairs(matchedContext) do
		debug.log("matched: "..v)
		table.insert(self.matched,v)
	end
	-- core.ptrn.oneword()
end

core.changeKeyMap = function(self,index)
	self.kmap:keymapWhenCompletionOn(index)
end
core.drop = function(self)
	self.isbusy = false
end
core.discard = function(self)
	self.isbusy = false
	self.kmap:clearmap()
end
core.complete = function(self)
	self.isbusy = (vim.fn.pumvisible()==1)
	self.kmap:clearmap()
end

core.displayCompletion = function(self)
	local len = string.len(self.ptrn:oneword())
	local col = self.pos[2]-(len-1)
	debug.log('displayCompletion, col: '..col)
	vim.fn.complete(col,self.matched)
	local index = vim.fn.complete_info({'selected'}).selected
	debug.log("selected_index: "..index)
	self:changeKeyMap(index)
end


return core
