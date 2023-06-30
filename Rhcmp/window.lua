local Window={};
local debug=require('common.debugMessagePrinter');debug.enable();
local api=require('Rhcmp.vimapi');
local maxWindowHeight = 20;

function Window:new()
	local self=setmetatable({},{__index=Window});
	self.buffers= {};
	self.wins   = {};
	self.winConfigs={};
	self.winOptions={};
	self.selitems=nil; -- it's an object that contain current selitems
	self:setupDefaultConfigs();
	return self;
end

function Window:setupDefaultConfigs()
	self.winConfigs={word={}};
	self.winOptions={word={}};
	local wordWindowConfig={
		relative='cursor',
		row=1,col=0,
		width =1,height=1,
		border='rounded',
		-- scrollable=true
	}
	self.winConfigs.word = wordWindowConfig;
	self.winOptions.word={
		winhighlight='Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
		wrap=false,
		scrolloff=0,
		sidescrolloff=0,
		number=false,
	}
	return;
end

-- The reset behavio will delete all existing buffers, window handles
function Window:reset()
	for ct,b in pairs(self.buffers) do
		debug.d(string.format("delete buffer[%s]",ct));
		api.deleteBuffer(b);
	end
	for ct,winh in pairs(self.wins) do
		debug.d(string.format("close window[%s]",ct));
		api.closeWindow(winh);
	end
	self.buffers.word=nil;
	self.wins.word=nil;
	self.selitems=nil;
	self:setupDefaultConfigs();
end

-- process actions when text change event happened, for window.
-- if source:hasCatches, then open or redraw
-- ct is completionType
-- create a window and fill items for it.
function Window:textChange(ct,s)
	if s:isEmpty() then
		return;
	end

	self.selitems=s;
	self:updateWindowConfigs(ct);
	local winh = self:getWinHandle(ct);
	self:fillItems(self.buffers[ct],s);

end

-- to fill the given selitems into the given buffer
function Window:fillItems(buf,sels)
	local t='word';
	local lines = self.selitems:getFillItems(t);
	api.setlines(buf,0,#lines,lines);
end

-- to update the winConfigs table according to given
-- selitems and completion type.
function Window:updateWindowConfigs(ct)
	--TODO
	local h=self.selitems:size();
	if h>maxWindowHeight then
		h=maxWindowHeight;
	end
	local w=self.selitems:maxWindowLength();
	local srow,scol = self.selitems:patternPosition('start');
	self.winConfigs[ct].height=h;
	self.winConfigs[ct].width=w;
	-- self.winConfigs[ct].row=srow;
	-- self.winConfigs[ct].col=scol;
end

-- to create a new window for ct, both a buffer by given self.winConfigs
function Window:createWinHandle(ct)
	self.buffers[ct]=api.newBuffer(); -- create buffer here
	self.wins[ct]=api.openWindow(self.buffers[ct],self.winConfigs[ct]);
	api.setWinOptions(self.wins[ct],self.winOptions[ct]);
	-- TODO, api.setWinOptions(self.wins[ct],options);
	-- return self.wins[ct];
end
-- update the existing wins[ct] with the updated configs
function Window:redrawExistingWindow(ct)
	api.setWinConfigs(self.wins[ct],self.winConfigs[ct]);
end

-- first need update window configs according to current selitems
-- then check if exists a wins[ct], redraw the window with updated configs
-- or else create a new window.
function Window:getWinHandle(ct)
	if self.wins[ct] ~= nil then
		self:redrawExistingWindow(ct);
	else
		self:createWinHandle(ct);
	end
	return self.wins[ct];
end

function Window:selectNextItem()
	-- update selindex and return the updated value.
	local ct='word';
	local selindex = self.selitems:incSelIndex();
	debug.d(string.format("inc index to:%d",selindex));
	api.setCursor(self.wins[ct],selindex);
	vim.cmd[[redraw]]; -- ?, not sure it's affection.
end
function Window:selectPrevItem()
	local ct='word';
	local selindex = self.selitems:decSelIndex();
	debug.d(string.format("dec index to:%d",selindex));
	api.setCursor(self.wins[ct],selindex);
	vim.cmd[[redraw]];
end
-- TODO, function Window:chooseItem()
-- TODO, end




return Window;
