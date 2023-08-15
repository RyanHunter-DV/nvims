local AutoCmds = {};

-- load class types
local Highlighter = require('RhDsl.Highlighter');
local Context = require('RhDsl.Context');

function AutoCmds:new()
	local self=setmetatable({},{__index=AutoCmds});
	-- create class objects.
	local self.hl = Highlighter:new();
	local self.context = Context:new();

	return self;
end

-- callback function when CursorMoved.
function AutoCmds:whenCursorMoved()
	self.hl:clearPreviousHighlight();
	local word = self.context:getCurrentWord();
	if word ~= nil then
		self.context:searchAllWords();
		self.hl:highlightAllMatchedWords(self.context);
	end
end

-- To setup auto commands while this tool is setup.
function AutoCmds:setupAutoCmds(ui)
	vim.api.nvim_create_autocmd(
		{"CursorMoved"},
		{callback=function()
			self:whenCursorMoved()
		end}
	);
end


return AutoCmds;
