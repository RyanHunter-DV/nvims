local C={};
local debug=require('common.debugMessagePrinter');debug.enable();
local api=require('Rhcmp.vimapi');

local blanks={' ','\t'}

function C:new()
	local self=setmetatable({},{__index=C});
	self.content='';
	self.srow=0;
	self.scol=0;
	debug.d(string.format("%d",self.scol));
	return self;
end

--
-- function C:textChanged()
-- end


-- return current completionType, for now it supports only 'word'
-- self.context:completionType() -> 'word'
function C:completionType()
	return 'word';
end

-- return if current content in cursor line has changed
-- and the change is not a space
function C:changed()
	-- code
	local s,srow,scol=self:getCurrentContent();
	debug.d(string.format("get content: (%s)",s));
	if self:isBlank(s) then
		-- return if current content before cursor is blank.
		debug.d("isBlank");
		return false;
	end
	if self.content==s then
		-- return if content not actually changed
		return false;
	end
	self:updateContent(s,srow,scol);
	return true;
end

-- update the object's content as the given arg
function C:updateContent(s,r,c)
	self.content=s;
	self.srow=r;
	self.scol=c;
end

function C:match(p,s)
	local t=p:match_str(s);
	debug.d(type(t));
	if p:match_str(s) then
		return true;
	end
	return false;
end

-- isBlank
-- according to given arg, if all chars in the arg are blank, then
-- return true, else return false.
function C:isBlank(s)
	local matched=true;
	local pos=0;

	debug.d(string.format("pos(%d),len(%d)",pos,string.len(s)));
	while(pos<string.len(s)) do
		local ptrn=vim.regex([=[[[:blank:]]]=]);
		-- if (not vim.tbl_contains(blanks,string.sub(s,pos,pos))) then
		debug.d(string.format("str(%s)",string.sub(s,pos,pos+1)));
		if (not self:match(ptrn,string.sub(s,pos,pos+1))) then
			debug.d(string.byte(string.sub(s,pos,pos+1)));
			debug.d("blank not matched, it is not blank");
			matched=false;
			break;
		end
		pos=pos+1;
	end
	return matched;
end

-- get the content before current cursor until gets a blank.
function C:getCurrentContent()
	local row,col = api.getCursor(0);
	local line = api.getCurrentLine();
	local lpos=col;
	local rpos=col+1;

	while (lpos>=1) do
		if self:isBlank(string.sub(line,lpos,lpos)) then
			break;
		end
		lpos = lpos-1;
	end
	if lpos==col then
		return ' ';
	end
	while (rpos<string.len(line)) do
		if self:isBlank(string.sub(line,rpos,rpos)) then
			break;
		end
		rpos=rpos+1;
	end
	lpos = lpos+1; -- skip the blank char
	rpos = rpos-1; -- skip the blank char
	return string.sub(line,lpos,rpos),row,lpos;
end

-- return the row,col position according to the given flag:
-- 'start', the start pos of this context, 0-based
-- 'tail', the end pos of this context, 0-based
function C:position(flag)
	if flag=='start' then
		debug.d(string.format("srow,scol(%d,%d)",self.srow,self.scol));
		return self.srow,self.scol;
	end
	local ecol = self.scol + string.len(self.content);
	debug.d(string.format("erow,ecol(%d,%d)",self.srow,ecol));
	return self.srow,ecol;
end

-- reset as completion cancelled, or completed
function C:reset()
	self.content='';
	self.srow=0;
	self.scol=0;
end


return C;
