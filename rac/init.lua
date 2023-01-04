-- this is the entry of RAC(RyanHunter's Atomic Completion tool) plugin
-- Author: RyanHunter
--

local auc  = require('common.autocmd')
local core = require('rac.core')
local debug= require('common.debug')
local synf
local loadSyntaxFile = function()
	local ft = vim.api.nvim_buf_get_option(0,'filetype')
	synf = require('rac.'..ft)
end

local onTextChangedI = function()
	local ignore = false
	ignore = ignore or (vim.fn.pumvisible() == 1)
	if ignore then
		return
	end
	core:init()
	debug.log("called textChangedP,line: "..vim.api.nvim_get_current_line())
	if core:processPattern(vim.api.nvim_get_current_line()) then
		core:drop()
		return
	end
	-- TODO, core.loadSyntax(synf)
	core:loadBufferContext()
	core:displayCompletion()
	-- complete should be called by auto: CompleteDone, core:complete()
end
local dropComplete = function()
	debug.log("dropComplete called")
	if vim.fn.pumvisible()==1 then
		core:discard()
		return
	end
end
local completeDone = function()
	debug.log("completeDone called")
	core:complete()
	return
end

vim.o.completeopt = 'menu,menuone,noinsert'
auc.subscribe({'BufNewFile','BufRead'},loadSyntaxFile)
auc.subscribe('TextChangedI',onTextChangedI)
auc.subscribe('InsertLeave',dropComplete)
auc.subscribe('CompleteDone',completeDone)
