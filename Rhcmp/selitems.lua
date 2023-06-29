local S={};
local debug=require('common.debugMessagePrinter');debug.enable();
local api=require('Rhcmp.vimapi');
local Selitem=require('Rhcmp.selitem');



function S:new(ctx)
	local self=setmetatable({},{__index=S});
	self.tags={};
	-- self.items={};
	local _r,_c = ctx:position('tail');
	-- debug.d(string.format("pattern position(%d,%d)",row,col));
	self.pattern={
		epos={row=_r,col=_c}, -- get context tail position
		content=ctx.content -- get content of the context
	};
	self.max={word=0};
	self.prefix='- ';
	-- 0-based
	self.selindex=0;
	-- items[word]={Syntax={'xxx','xxx'},Buffer={'xxx','xx'}}
	self.items={word={}};
	return self;
end

-- function S:setPattern(cnt)
-- 	local crow,ccol = api.getCursor(0);
-- 	self.pattern.epos={row=crow,col=ccol};
-- 	self.pattern.content=cnt;
-- end
function S:registered(tag)
	if vim.tbl_contains(self.tags,tag) then
		return true;
	end
	table.insert(self.tags,tag);
	return false; -- first register, to return false.
end

-- add item into this object
function S:addItem(tag,item)
	local ct='word';

	local si=Selitem:new(tag,item);
	table.insert(self.items[ct],si);

	-- if not self:registered(tag) then
	-- 	self.items.word[tag]={};
	-- end

	---- skip duplicated adding
	--if not vim.tbl_contains(self.items.word[tag],item) then
	--	debug.d(string.format("additem(%s) with tag(%s)",item,tag));
	--	table.insert(self.items.word[tag],item);
	--end
end

-- size of stored selitems
-- t is tag
function S:size(ct)
	ct = (ct==nil and 'word') or ct; -- default tag is 'word'
	return #self.items[ct];
end

function S:isEmpty()
	if self:size()>0 then
		return false;
	end
	return true;
end

-- max length for completion window, shall be the max item length + 10
-- this function not support 'all' tag, which means to get all information form
-- current existing tags
function S:maxlen(ct)
	local max=0;
	for index,item in ipairs(self.items[ct]) do
		-- local l=string.len(item..t);
		local l=item:length();
		if max < l then
			max=l;
		end
	end
	self.max[ct]=max;
	return self.max[ct];
end

-- support multiple tags
-- function S:maxlen(t)
-- 	local ts={t};
-- 	if t=='word' then
-- 		ts=vim.tbl_keys(self.items[t]);
-- 	end
-- 
-- 	local lens={};
-- 	local max=0;
-- 	for _,_t in ipairs(ts) do
-- 		table.insert(lens,self:maxlenOfOneTag(_t));
-- 	end
-- 
-- 	for _,l in ipairs(lens) do
-- 		if max < l then
-- 			max=l;
-- 		end
-- 	end
-- 
-- 	return max;
-- end


function S:maxWindowLength(t)
	t = (t==nil and 'word') or t; -- default tag is 'word'
	-- use this to reduce the calculation times of maxlen
	local max = self:maxlen(t);
	debug.d(string.format("get maxlen: %d",max));
	return max;
end

-- return the cursor(row,col) of the pattern, according to flag
-- support flag='start', or 'end'
function S:patternPosition(flag)
	local row = self.pattern.epos.row;
	local col = self.pattern.epos.col;
	debug.d(string.format("pattern pos:(%d,%d)",row,col));
	if flag=='start' then
		local l = string.len(self.pattern.content);
		col = col - l;
	end
	debug.d(string.format("pattern position(%s): %d,%d",flag,row,col));
	return row,col;
end

-- increment the selection index
function S:incSelIndex()
	local t='word';
	self.selindex = self.selindex + 1;
	if self.selindex > s:size(t) then
		self.selindex=0;
	end
end

-- decreate the selection index
function S:decSelIndex()
	local t='word';
	if self.selindex <= 1 then
		self.selindex = s:size(t)-1;
	else
		self.selindex = self.selindex - 1;
	end
end

-- return the selitem of the current selIndex 
function S:getSelectedItem()
	local ct='word';
	return self.items[ct][self.selindex+1].content;
end

-- return the pattern
function S:getPattern()
	return self.pattern.content;
end

-- return a list that contains the items formatted that can be 
-- directly placed to the completion buffer.
-- t is tag
function S:getFillItems(t)
	local lines={};

	debug.d(string.format("call get fill item of tag(%s)",t));
	for index,item in ipairs(self.items[t]) do
		local line= item:formatted(self.prefix,self.max[t]);
		-- local sup = string.rep(' ',self.max[t]-string.len(item..t..self.prefix..'[]'));
		-- local line = self.prefix..item..sup..'['..t..']';
		debug.d(string.format("get fill item(%s)",line));
		table.insert(lines,line);
	end
	return lines;
end

--function S:getFillItems(t)
--	local ts={t};
--	if t=='word' or t=='all' then
--		ts=vim.tbl_keys(self.items);
--	end
--	-- local lines={};
--	for _,_t in ipairs(ts) do
--		local nls = self:getFillItemsOfOneTag(_t);
--		for _,nl in ipairs(nls) do
--			table.insert(self.formattedItems,nl);
--		end
--	end
--
--	return self.formattedItems;
--end

-- return position of the string formatted selitems
-- used by highlighter
-- index: selitem index, 0-based
-- returns: a table
-- patternS => pattern start position
-- patternE => pattern end position
-- tagS => tag start position
-- tagE => tag end position
-- pos => {row,col}
function S:getFormattedPosition(index)
	local ct='word';
	local pos={patternS={},patternE={},tagS={},tagE={},prefixS={},prefixE={}};
	local si=self.items[ct][index+1];
	pos.patternS={index+1,3};
	pos.patternE={index+1,3+string.len(self.pattern.content)};
	pos.tagE={index+1,self.max[ct]+1}; -- include ']'
	pos.tagS={index+1,self.max[ct]-1-string.len(si.tag)}; -- include '['
	pos.prefixS={index+1,0};
	pos.prefixE={index+1,2};

	return pos;
end


return S;
