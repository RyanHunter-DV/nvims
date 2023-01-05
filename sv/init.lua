-- local cmd = require('common.command')

print("sv.init file loaded")

local sv = {}
local uvm= {}

uvm.drv = require('sv.driver')
sv.fh   = require('sv.fileop')
sv.pg   = require('sv.package')

vim.api.nvim_create_user_command('Driver',function(args)
	-- local cn = vim.api.nvim_get_current_line()
	uvm.drv:classblock(args.args)
end,{force=true,nargs=1})

local fileHeaderCmd = function()
	sv.fh:createFileHeader()
end
local packageCmd = function(pn)
	sv.pg:createPackage(pn)
end

vim.api.nvim_create_user_command('FileHeader',fileHeaderCmd,{force=true})
vim.api.nvim_create_user_command('Package',function(args)
	sv.pg:createPackage(args.args)
	end,{force=true,nargs=1}
)

-- for comments
-- vim.api.nvim_set_keymap('i','s//','')
