-- local cmd = require('common.command')

local sv = {}
local uvm= {}

uvm.drv = require('sv.driver')

vim.api.nvim_create_user_command('Driver',function()
	local cn = vim.api.nvim_get_current_line()
	uvm.drv:classblock(cn)
end,{force=true})
