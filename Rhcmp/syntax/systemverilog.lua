local syntax={};
local debug=require('common.debugMessagePrinter');debug.enable();

-- for keywords, which will be matched when typing part of chars, like:
-- when typing f, the function/for/fork... will be placed as the matched
-- words
local keywords = {
	'bit','byte',
	'function','task',
	'for',
	'fork',
};

-- matches is a long line that when matching the first start of the chars
-- the consequent string sequence will be shown as selection items.
local matches = {
	'int unsigned'
}

syntax.searchBuiltins=function(pattern)
	local completions={};
	for _,word in ipairs(keywords) do
		local s,e = pattern:match_str(word);
		if s and e then
			-- push current keyword to completions
			table.insert(completions,word)
			debug.d(string.format("keyword: %s matched",word));
		end
	end
	return completions;
end

return syntax;
