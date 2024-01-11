local Context={};
local debug=require('common.debugMessagePrinter');debug.enable();

function Context:new()
	local self=setmetatable({},{__index=Context});

	self.separators = {[=[:blank:]=],[=[:space:]=]};

	return self;
end

-- public
function Context:getCurrentWord()
	-- get the word where current cursor exists
	-- if current cursor not locates in any word, then return nil
	-- TODO
	local cursor = vim.api.nvim_win_get_cursor(0);
	local line = vim.api.nvim_get_current_line();
	if self:isSeparator(line,cursor[2]) then
		return nil;
	else
		return self:filterSelectedWord(line,cursor[2]);
	end
end

function Context:searchAllWords(w)
	-- API to search all words in current buffer, record
	-- all positions (col,row), return all searched positions
	-- TODO
end


-- private
function Context:isSeparator(src,pos)
	-- if src.sub(pos) is separator, return true, else
	-- return false.
	local c = string.sub(src,pos,pos);
	for _,sep in ipairs(self.separators) do
		if str.gmatch(c,sep)~=nil then
			return true;
		end
	end
	return false;
end

function Context:filterSelectedWord(src,pos)
	-- filter out the word where the pos located in

	local leftPos=0;
	local rightPos=0;
	-- find lest pos
	for i=pos-1,0,-1 do
		if (self:isSeparator(string.sub(src,i,i))) then
			leftPos = i+1;
			break;
		end
	end

	for i=pos+1,string.len(src)-1 do
		if (self:isSeparator(string.sub(src,i,i))) then
			rightPos = i-1;
			break;
		end
	end
	local matched = string.sub(src,leftPos,rightPos);
	debug.d(string.format("get matched word(%s)",matched));
	return matched;
end

return Context;
