local debug=require('common.debugMessagePrinter');debug.enable();

local core={};
local AutocmdManager=require('Rhcmp.autocmd');
local Context= require('Rhcmp.context');
local Source = require('Rhcmp.source');
local Keymap = require('Rhcmp.keymap');
local Window = require('Rhcmp.window');
local am=AutocmdManager.new();
local source = Source.new();
local context= Context.new();
local keymap = Keymap.new();
local window = Window.new();

local status = {};
status.IDLE     = 0;
status.COMPLETED= 1;
status.CANCELED = 2;
status.ACTIVE   = 3;

core.new=function(self)
	local self=setmetatable({},{__index=core});
	self.status = status.IDLE;
	return self;
end

-- process user input configures into local supported
-- configs and options.
core.uiOperation=function(self,configs)
	-- TODO
end

core.whenTextChanged=function(self)
	-- debug.d(string.format("text changed, current context: %s",context:lineBeforeCursor()));
	local changed,ctx = context:isChanged();
	if changed==true and ctx~='' then
		debug.d(string.format("context changed, now is:%s",ctx));
		context:update(ctx);
		catches = source:search(context);
		if catches:empty()==true then
			debug.d(string.format("ctx: %s, catches are empty",ctx));
			self:clearStatus();
			-- window:close();keymap:reset();
		else
			debug.d(string.format("ctx: %s, catches are not empty",ctx));
			window:render(catches,function()
				self.status=status.ACTIVE;
				keymap:completionMapping(window);
			end);
		end
	elseif (ctx=='') then
		self:clearStatus();
		-- window:close();keymap:reset();
	end
end
core.clearStatus=function(self)
	if (self.status~=status.COMPLETED and self.status~=status.IDLE) then
		context:reset();
		window:close();keymap:reset();
	end
	self.status=status.IDLE;
end
core.whenLeaveInsert=function(self)
	self:clearStatus();
end
core.chooseItem=function(self,t)
	window:chooseItem(t);
	keymap:reset();
	self.status=status.COMPLETED;
end
core.selectNextItem=function(self,t)
	window:selectNextItem(t);
end
core.selectPrevItem=function(self,t)
	window:selectPrevItem(t);
end

core.setup=function(self,configs)
	-- debug.d("call uiOperation");
	self:uiOperation(configs);
	-- debug.d("call setupGenericAutoCmd");
	-- core.autocmd:setupGenericAutoCmd(core);
	local textChangeAction=function()
		-- debug.d("textChangedAction called");
		self:whenTextChanged();
	end
	local insertLeaveAction=function()
		self:whenLeaveInsert();
	end

	-- setup autocmds
	am:setup({'TextChangedI','TextChangedP'},textChangeAction);
	am:setup({'InsertLeave'},insertLeaveAction);

	source:setup(); -- preloads grammers and snippets first time it been called
end
core.start=function(self)
	--TODO
end

return core;
