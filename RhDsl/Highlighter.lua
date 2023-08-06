local Highlighter={};

-- public

function Highlighter:new()
	local self=setmetatable({},{__index=Highlighter});
	local self.highlighed = false;

	return self;
end

function Highlighter:clearPreviousHighligh()
	if self:hasHighlighted() == true then
		self.clearHighlight();
	end
	return;
end

-- according all matched words and positions in ctx object, render those by ext marks
-- TODO
function Highlighter:highlightAllMatchedWords(ctx)
end




-- private

function Highlighter:hasHighlighted()
	-- TODO
end

function Highlighter:clearHighlight()
	-- TODO
end


return Highlighter
