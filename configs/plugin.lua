local s={};
s.setup=function(home)
	require('cmp-config').setup(home);
	require('theme-config')
	require('ts-config')
	require('ll-config')
	-- require('init.tmux-config')
	-- require('init.lsp-config')
	--TODO, require('luasnip-config')
	require('tterm-config').setup(home);
end
return s;
