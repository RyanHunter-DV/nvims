local highlight={};
--highlight.keys = {
--  'fg',
--  'bg',
--  'bold',
--  'italic',
--  'reverse',
--  'standout',
--  'underline',
--  'undercurl',
--  'strikethrough',
--}
--
--highlight.inherit = function(name, source, settings)
--  for _, key in ipairs(highlight.keys) do
--    if not settings[key] then
--      local v = vim.fn.synIDattr(vim.fn.hlID(source), key)
--      if key == 'fg' or key == 'bg' then
--        local n = tonumber(v, 10)
--        v = type(n) == 'number' and n or v
--      else
--        v = v == 1
--      end
--      settings[key] = v == '' and 'NONE' or v
--    end
--  end
--  vim.api.nvim_set_hl(0, name, settings)
--end

local created=false;
local debug=require('common.debugMessagePrinter');debug.enable();

highlight.new=function()
	local self=setmetatable({},{__index=highlight});
	self.nsid={};
	if created==false then
		self:createNamespaces();
		-- created=true;
	end
	self.scheme = {
		--RhcmpMatchedItem = {fg='#504945',bg='#98be65'},
		RhcmpMatchedItem = {fg='#afd700'},
		RhcmpTagItem = {fg='#cba6f0'},
	}
	self.buffer=nil;
	self.win=nil;
	return self;
end
highlight.setWindowAndBuffer=function(self,buf,win)
	self.buffer=buf;
	self.win =win;
end
highlight.createNamespaces=function(self)
	self.spaces = {'RhcmpMatchedItem','RhcmpTagItem'};
	for _,ns in ipairs(self.spaces) do
		self.nsid[ns] = vim.api.nvim_create_namespace(ns);
	end
end

highlight.setMatchedItem=function(self,line,len)
	local ns=self.spaces[1];
	local sindex=2;
	local eindex=sindex+len;
	debug.d(string.format("matchedItem positions, line:%d,col:%d,ecol:%d",line,sindex,eindex));
	local configs={end_row=line-1,end_col=eindex,hl_group=ns,hl_mode='combine'};
	self:set(ns,line-1,sindex,configs);
end

highlight.setTagItem=function(self,linepos,tags,tage)
	local ns=self.spaces[2];
	debug.d(string.format("positions, line:%d,col:%d,ecol:%d",linepos,tags,tage));
	-- end_col is index from 0, if end_col=3, then the 4th char will not be rendered.
	local configs={end_row=linepos-1,end_col=tage,hl_group=ns,hl_mode='combine'};
	self:set(ns,linepos-1,tags-1,configs);
end

local registers={};
highlight.registered=function(self,winh,ns)
	for h,n in pairs(registers) do
		if registers[h] == ns then
			return true;
		end
	end
	return false;
end
highlight.register=function(self,winh,ns)
	registers[winh]=ns;
end
-- set highlight and mark
highlight.set=function(self,ns,srow,scol,configs)
	debug.d(string.format("processing ns: %s",ns));
	vim.api.nvim_set_hl(0,ns,self.scheme[ns]);
	-- if not self:registered(self.win,ns) then
	-- 	vim.api.nvim_win_set_hl_ns(self.win,self.nsid[ns]);
	-- 	vim.api.nvim_set_hl(self.nsid[ns],ns,self.scheme[ns]);
	-- 	self:register(self.win,ns);
	-- end
	vim.api.nvim_buf_set_extmark(self.buffer,self.nsid[ns],srow,scol,configs);
end



return highlight;
