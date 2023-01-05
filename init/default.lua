require('init.basic')
require('init.plugin')
require('init.plugin-config')

vim.cmd([[au FileType systemverilog lua require('sv.init') ]])
