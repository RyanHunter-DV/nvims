-- object to setup Rhcmp auto commands by using a common autocmd API
local Autocmd=require('common.autocmd');
local debug=require('common.debugMessagePrinter');debug.enable();
local AutoManager={};

function AutoManager:new(c)
	local self=setmetatable({},{__index=AutoManager});
	self.au = Autocmd.new('___RhcmpAutocmds___');
	self.core=nil;
	return self;
end

-- public API called by core. to setup the whole autocmds of Rhcmp.
function AutoManager:setup(c)
	self.core = c;
	debug.d("setupInsertLeave");
	self:setupInsertLeave();
	debug.d("setupTextChanged");
	self:setupTextChanged();
	debug.d("setupInsertEnter");
	self:setupInsertEnter();
end

-- - TextChangedI, TextChangedP, 
-- every time text changed detected, need to flush the Rhcmp tool's
-- completion flow, from updating context, to redraw the window and buffer.
function AutoManager:setupTextChanged()
	local events = {'TextChangedI','TextChangedP'};
	local cb = function()
		self.core:whenTextChanged();
	end
	self.au:subscribe(events,cb);
end

-- - InsertLeave
-- to clear remaining onetime completion fields.
function AutoManager:setupInsertLeave()
	local events={'InsertLeave'};
	local cb= function()
		self.core:whenInsertLeave();
	end
	self.au:subscribe(events,cb);
end
-- - InsertEnter, for source, to update the keywords of a buffer
function AutoManager:setupInsertEnter()
	local events={'InsertEnter'};
	local cb=function()
		self.core:whenInsertEnter();
	end
	self.au:subscribe(events,cb);
end


return AutoManager;
