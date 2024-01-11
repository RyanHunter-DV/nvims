local s={};
s.setup=function(home)
	require('cmp-config').setup(home);
	require('theme-config')
	require('ts-config').setup(home);
	require('ll-config').setup(home);
	-- require('init.tmux-config')
	-- require('init.lsp-config')
	require('luasnip-config').setup(home);
	require('tterm-config').setup(home);
end
return s;
