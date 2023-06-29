-- source object is used to get the selitems from the source by the given pattern
local S={};
local debug=require('common.debugMessagePrinter');debug.enable();
local Selitems=require('Rhcmp.selitems');
local api=require('Rhcmp.vimapi');

function S:new()
	local self=setmetatable({},{__index=S});
	self.syntax=nil;
	return self;
end

-- according to the given context, grep from different sources and return
-- the selitem
-- ctx is an object of Context, which has content and position attributes.
function S:captureSelitems(ctx)
	local selitem = Selitems:new(ctx);
	-- local items = {};
	for _,s in ipairs(self:searchFromKeywords(ctx.content)) do
		selitem:addItem('Syntax',s);
	end
	for _,s in ipairs(self:searchFromBuffer(ctx)) do
		selitem:addItem('Buffer',s);
	end
	return selitem;
end

function S:searchFromKeywords(content)
	local ptrn = vim.regex(string.format("^%s",content));
	local items={};
	for _,w in ipairs(self.syntax.keywords) do
		if ptrn:match_str(w) and (not vim.tbl_contains(items,w) and w~=content) then
			table.insert(items,w);
		end
	end
	return items;
end

-- function that been called every time the InsertEnter happened
-- to filter all keywords of this buffer and stored for later completion.
function S:updateBufferWords()
	--TODO
end

-- To search keywords from current buffer, but need to remove
-- current pattern
function S:searchFromBuffer(ctx)
	return {}; -- TODO
end

-- loadSyntax,
-- to load the syntax file according to the filetyp
function S:loadSyntax()
	local ft = api.getFileType();
	self.syntax=require(string.format('Rhcmp.syntax.%s',ft));
	return;
end

function S:reset()
	-- nothing to do for now.
end


return S;
