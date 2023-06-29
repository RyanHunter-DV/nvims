-- local M={};
local Core={};
local debug=require('common.debugMessagePrinter');debug.enable();
local AutoManager=require('Rhcmp.autoManager');
local Window=require('Rhcmp.window');
local Source=require('Rhcmp.source');
local Highlighter=require('Rhcmp.highlighter');
local Keymap=require('Rhcmp.keymap');
local Context=require('Rhcmp.context');
local api=require('Rhcmp.vimapi');

-- initialize API, to setup default configs, and information
function Core:new(configs)
	debug.d("Core:new() ...");
	local self=setmetatable({},{__index=Core});
	self.am = AutoManager:new();
	self.window = Window:new();
	self.source = Source:new();
	self.hl = Highlighter:new();
	self.keymap=Keymap:new();
	self.context=Context:new();
	self.selitems=nil;
	self.completionOn=false
	-- TODO, self:setUserConfigs();
	-- TODO, for user config, local groups=vim.tbl_keys(configs);
	-- TODO, for user config, if vim.tbl_contains(groups,'window') then
	-- TODO, for user config, 	self.window:setConfigs(configs.window);
	-- TODO, for user config, end
	return self;
end

-- TODO, for user config, function Core:setUserConfigs(configs)
-- TODO, for user config, end

-- API called by init, to start completion by adding autocmds
-- and its relative APIs.
function Core:start()
	-- TODO
	debug.d("setupAutoCommands");
	self:setupAutoCommands();
	debug.d("loadSyntax");
	self.source:loadSyntax();
end

-- internal API to setup auto commands, called by self:start
-- Procedures:
function Core:setupAutoCommands()
	--TODO
	self.am:setup(self);
end

-- callbacks for autocmds
-- Procedures:
-- 1. get context of current word, Rhcmp can only search for a word
-- 2. catching selectable items from source
-- 3. create a window.
-- 4. create a buffer for filling items.
-- 5. setup highlight configs for that buffer
-- 6. to temporary change the keymap while completion is on.
function Core:whenTextChanged()
	debug.d("call whenTextChanged");
	if self.context:changed() then
		-- TODO, currently not used, self.context:textChanged();
		local ct = self.context:completionType();
		self.selitems=self.source:captureSelitems(self.context);
		self.window:textChange(ct,self.selitems);
		self.hl:textChange(self.window,ct,self.selitems);
		self.keymap:completionOn(self);
		self.completionOn=true;
	else
		if (self.completionOn) then
			self:resetCompletion();
		end
	end
end

function Core:resetCompletion()
	self.context:reset();
	self.source:reset();
	-- hl shall be reset before window, or else the buffer may be deleted.
	self.hl:reset();
	self.window:reset();
	self.keymap:reset();
	self.selitems=nil; -- reset
	self.completionOn=false;
end

-- all context, source, window, and hl shall be reset.
function Core:whenInsertLeave()
	if self.completionOn then
		self:resetCompletion();
	end
end
-- TODO
function Core:whenInsertEnter()
	self.source:updateBufferWords();
end

-- APIs for selections --

-- This API will not only select the highlight cursorline to next item,
-- but also will place a temporary text into current window
function Core:selectNextItem()
	self.window:selectNextItem();
	-- TODO, self:placeSelectedItem
end
-- This API will not only select the highlight cursorline to prevous item,
-- but also will place a temporary text into current window
function Core:selectPrevItem()
	self.window:selectPrevItem();
	-- TODO, self:placeSelectedItem
end
function Core:chooseItem()
	-- local selected = self.window.selitems:getSelectedItem();
	-- local pattern  = self.window.selitems:getPattern();
	local bs=self.keymap:backspace(self.context.content);
	local selected=self.selitems:getSelectedItem();
	api.feedkeys(bs..selected);

	-- completion done.
	self:resetCompletion();
end


return Core;
