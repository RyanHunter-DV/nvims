local api={};
local vi=vim.api

api.openWindow=function(buf,configs)
	local winh = vi.nvim_open_win(buf,false,configs);
	return winh;
end
api.newBuffer=function()
	local buf= vi.nvim_create_buf(false,true);
	return buf;
end

api.setWinConfigs=function(winh,configs)
	vi.nvim_win_set_config(winh,configs);
	vim.cmd[[redraw]];
end
api.setWinOptions=function(winh,opts)
	for n,v in pairs(opts) do
		vi.nvim_win_set_option(winh,n,v);
	end
end
api.getCursor=function(winh)
	local pos=vi.nvim_win_get_cursor(winh);
	return pos[1],pos[2];
end
api.getCurrentLine=function()
	return vi.nvim_get_current_line();
end
api.setlines=function(b,s,e,lines)
	vi.nvim_buf_set_lines(b,s,e,false,lines);
end

api.createNamespace=function()
	local ns = '___Rhcmp___';
	return vi.nvim_create_namespace(ns);
end

api.createCommand=function(name,cmd)
	vi.nvim_buf_create_user_command(0,name,cmd,{});
end
api.createKeymap=function(key,action)
	vi.nvim_buf_set_keymap(0,'i',key,action,{});
end
api.deleteKeymap=function(key)
	vi.nvim_buf_del_keymap(0,'i',key);
end
api.deleteBuffer=function(b)
	if vi.nvim_buf_is_valid(b) then
		vi.nvim_buf_delete(b,{});
	end
end
api.feedkeys=function(keys)
	vi.nvim_feedkeys(keys,'i',true);
end
api.getFileType=function()
	return vi.nvim_buf_get_option(0,'filetype');
end
api.closeWindow=function(winh)
	if vi.nvim_win_is_valid(winh) then
		vi.nvim_win_hide(winh);
	end
end



return api;
