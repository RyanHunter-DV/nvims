vim.cmd [[autocmd!___cmp___]]
local ns='RhcmpTag';
local nsid = vim.api.nvim_create_namespace(ns);


vim.api.nvim_set_hl(0,ns,{fg='#504945',bg='#afd700'});
-- vim.api.nvim_set_hl(0,ns,{link='PmenuThumb',default=false});
vim.api.nvim_buf_set_extmark(0,nsid,0,0,{
	end_row=0,end_col=3,hl_group=ns,hl_mode='combine'
});
