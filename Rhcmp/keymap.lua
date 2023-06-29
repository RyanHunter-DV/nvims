local K={};
local debug=require('common.debugMessagePrinter');debug.enable();
local api=require('Rhcmp.vimapi');


function K:completionOn(core)
	self.core=core;
	self:mapping();
end



function K:mapping()
	api.createCommand(self.selnextitem['cmd'],function()
		self.core:selectNextItem();
	end);
	api.createKeymap(self.selnextitem['key'],string.format('<Cmd>%s<CR>',self.selnextitem['cmd']));
	api.createCommand(self.selprevitem['cmd'],function()
		self.core:selectPrevItem();
	end);
	api.createKeymap(self.selprevitem['key'],string.format('<Cmd>%s<CR>',self.selprevitem['cmd']));
	api.createCommand(self.chooseitem['cmd'],function()
		self.core:chooseItem();
	end);
	api.createKeymap(self.chooseitem['key'],string.format('<Cmd>%s<CR>',self.chooseitem['cmd']));
	self.keymapped=true;
end

function K:reset()
	if self.keymapped==false then
		return;
	end
	api.deleteKeymap(self.selnextitem['key']);
	api.deleteKeymap(self.selprevitem['key']);
	api.deleteKeymap(self.chooseitem['key']);
	self.keymapped=false;
end

function K:t(keys)
  return (string.gsub(keys, '(<[A-Za-z0-9\\%-%[%]%^@]->)', function(match)
    return vim.api.nvim_eval(string.format([["\%s"]], match))
  end))
end
-- generate <BS> keys to remove the given word
function K:backspace(word)
	local count=string.len(word);
	if count < 0 then
		return '';
	end
	return self:t(string.rep('<BS>',count));
end

function K:new()
	local self=setmetatable({},{__index=K});
	self.core=nil;
	self.keymapped=false;
	self.selnextitem={cmd='RhcmpSelectNextCompletionItem',key='<c-n>'};
	self.selprevitem={cmd='RhcmpSelectPrevCompletionItem',key='<c-p>'};
	self.chooseitem ={cmd='RhcmpChooseCompletionItem',key='<Tab>'};
	return self;
end

return K;
