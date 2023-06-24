-- This is an object for selectable item that has item context, and relative
-- attributes such like the highlight information, position etc.
-- Using example:
-- a = Selitem.new(<maxlen>)
local selitem={};
local debug=require('common.debugMessagePrinter');debug.enable();

selitem.new=function(l,pre)
	local self=setmetatable({},{__index=selitem});
	-- max len should be of this selitem, if real context not reaches this length,
	-- then use ' ' to suppliment like: - <contextitem>      [<tag>]
	self.maxlen = l; 
	-- the global max line, which shall be real max line + fixnum
	debug.d(string.format("get l type: %s, l: %d",type(l),l));
	self.gmax   = l + 10;
	-- prefix, that to be placed at the start of each selitem, by default it's '-'
	-- - <contextitem>   [<tag>]
	self.prefix =pre..' ';
	self.context='';
	self.tag='';
	self.line=0;
	self.suppliment='';
	self.tagpos={_s=0,_e=0};
	return self;
end

-- Return the startCol,endCol of the tag of this selitem, shall contain the
-- '[]' quota. This will be used by a highlighter to set the extmark
selitem.getTagPosition=function(self)
	return self.tagpos._s,self.tagpos._e;
end

selitem.formatting=function(self)
	local supcount = self.gmax-4-string.len(self.context..self.tag);
	self.suppliment=string.rep(' ',supcount);
	local s=supcount+string.len(self.prefix..self.context..'[');
	local e=s+string.len(self.tag..']');
	debug.d(string.format("l: %s",self:get()));
	debug.d(string.format("get tag position: s:%d, e%d",s,e));
	self.tagpos._s=s;
	self.tagpos._e=e;
end
-- set line context to this object, with item string and tag string.
selitem.setContext=function(self,item,tag)
	self.context=item;
	self.tag=tag;
	self:formatting();
end

-- set line position of this selectable item.
-- if arg:line is nil, then return the current line position
selitem.linePosition=function(self,line)
	if line==nil then
		return self.line;
	end
	self.line=line;
end

-- return a string that will be placed at the Pmenu
-- <prefix> <context>     [<tag>]
selitem.get=function(self)
	return self.prefix..self.context..self.suppliment..'['..self.tag..']';
end

-- get the raw selectable context
selitem.getRaw=function(self)
	return self.context;
end



return selitem;
