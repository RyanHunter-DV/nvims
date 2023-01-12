-- local cmd = require('common.command')

print("sv.init file loaded")

local sv = {}
local uvm= {}

uvm.drv = require('sv.driver')
uvm.agt = require('sv.agent')
sv.fh   = require('sv.fileop')
sv.pg   = require('sv.package')

vim.api.nvim_create_user_command('Driver',function(args)
	uvm.drv:classblock(args.args)
end,{force=true,nargs=1})
vim.api.nvim_create_user_command('Agent',function(args)
	uvm.agt:classblock(args.args)
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
-- new added from here
sv.method = require('sv.method')
-- call command like:
-- :Func void funcname (input int a[$],input int b)
vim.api.nvim_create_user_command('Func',function(args)
	sv.method:defmethod('func',args.args)
end,{force=true,nargs=1})
vim.api.nvim_create_user_command('Task',function(args)
	sv.method:defmethod('task',args.args)
end,{force=true,nargs=1})
vim.api.nvim_create_user_command('VFunc',function(args)
	sv.method:virtual()
	sv.method:defmethod('func',args.args)
	sv.method:reset()
end,{force=true,nargs=1})
vim.api.nvim_create_user_command('VTask',function(args)
	sv.method:virtual()
	sv.method:defmethod('task',args.args)
	sv.method:reset()
end,{force=true,nargs=1})
-- new added finished
uvm.obj = require('sv.object')
vim.api.nvim_create_user_command('Object',function(args)
	uvm.obj:classblock(args.args)
end,{force=true,nargs=1})
