local H={};
local debug=require('common.debugMessagePrinter');debug.enable();
local api=require('Rhcmp.vimapi');


-- when text change happened, and after window opened
-- to setup extmarks and highlighters for current window/buffer.
-- winh -> window handle
-- ct -> completion type
-- s -> selitem object
function H:textChange(winh,ct,s)
	local size = s:size();
	local index=0;
	while (index<size) do
		local pos = s:getFormattedPosition(index);

		self:setMark(self.spaces[1],winh.buffers[ct],pos.patternS,pos.patternE);
		self:setMark(self.spaces[2],winh.buffers[ct],pos.tagS,pos.tagE);
		self:setMark(self.spaces[3],winh.buffers[ct],pos.prefixS,pos.prefixE);
		self.buffer = winh.buffers[ct];
		vim.api.nvim_win_set_hl_ns(winh.wins.word,self.nsid);

		index = index+1;
	end
end

function H:getMarkId()
	-- code
	local id=self.markid;
	self.markid = self.markid+1;
	return id;
end

function H:setMark(ns,buf,spos,epos)
	local config = {
		id=self:getMarkId(),
		end_row=epos[1]-1,
		end_col=epos[2]-1,
		hl_group=ns,
		hl_mode='combine'
	}
	debug.d(string.format("set extmark, ns: %s",ns));
	debug.d(string.format("set extmark, endpos(%d,%d)",epos[1]-1,epos[2]-1));
	self:set(buf,spos,config);
end
-- set highlight and mark
function H:set(buf,spos,configs)
	debug.d(string.format("set extmark, pos(%d,%d)",spos[1]-1,spos[2]-1));
	vim.api.nvim_buf_set_extmark(buf,self.nsid,spos[1]-1,spos[2]-1,configs);
end


function H:sethl()
	for _,ns in ipairs(self.spaces) do
		debug.d(string.format("set hl,group(%s),nsid(%s)",ns,self.nsid));
		vim.api.nvim_set_hl(self.nsid,ns,self.scheme[ns]);
	end
end

-- clear all buffer related marks
-- don't need to clear the hl and namespace
function H:reset()
	local id=1;
	while (id < self.markid) do
		debug.d(string.format("types,buf(%s),nsid(%s),id(%s)",type(self.buffer),type(self.nsid),type(id)));
		vim.api.nvim_buf_del_extmark(self.buffer,self.nsid,id);
		id = id+1;
	end
	self.markid=1;
end

function H:new()
	local self=setmetatable({},{__index=H});
	self.nsid = api.createNamespace();
	self.spaces={'RhcmpContext','RhcmpTag','RhcmpPrefix'};
	self.scheme = {
		RhcmpContext = {fg='#afd700'},
		RhcmpTag     = {fg='#cba6f0'},
		RhcmpPrefix  = {fg='#afd700'},
	}
	self.markid=1;
	self.buffer=nil;
	self:sethl();
	return self;
end

return H;
