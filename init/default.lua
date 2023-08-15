require('init.basic')
require('init.plugin')
require('init.plugin-config')

vim.cmd([[au FileType systemverilog lua require('sv.init') ]])
vim.cmd([[au FileType ruby lua require('ruby.init') ]])

-- set for default gui font
vim.o.guifont="JetBrains Mono:h12"
