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

core.new=function(self)
	local self=setmetatable({},{__index=core});
	debug.d('core initialized');
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
		catches = source:research(context);
		if catches:empty()==true then
			debug.d(string.format("ctx: %s, catches are empty",ctx));
			window:close();keymap:reset();
		else
			debug.d(string.format("ctx: %s, catches are not empty",ctx));
			window:render(catches,function()
				keymap:completionMapping(window);
			end);
		end
	elseif (ctx=='') then
		window:close();keymap:reset();
	end
end
core.whenLeaveInsert=function(self)
	context:reset();
	window:close();keymap:reset();
end

core.setup=function(self,configs)
	debug.d("call uiOperation");
	self:uiOperation(configs);
	debug.d("call setupGenericAutoCmd");
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
