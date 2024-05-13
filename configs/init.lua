local path=debug.getinfo(1).source;

local config={};

config.basicVimSettings = function()
	vim.wo.cursorline = true
	vim.wo.number     = true
	vim.o.ts          = 4
	vim.o.shiftwidth  = 4
	vim.o.incsearch   = true
	vim.o.hlsearch    = true
	vim.o.cindent     = true
	-- set for default gui font
	vim.o.guifont="JetBrains Mono:h12"
	
	vim.cmd ([[ set foldmethod=marker ]])
	if vim.g.neovide==true then
		vim.cmd ([[ set mouse=na ]])
	else
		vim.cmd ([[ set mouse= ]])
	end
	-- vim.cmd([[ set nowrap ]])
	vim.cmd([[ set foldmarker=##{{{,##}}} ]])
	vim.cmd([[au BufRead,BufNewFile *.rh set filetype=ruby]])
	vim.cmd([[au BufRead,BufNewFile *.svh.src,*.sv.src set filetype=ruby]])
	-- TODO, vim.cmd([[au FileType ruby setlocal shiftwidth=4 ]])
	vim.cmd([[au FileType * setlocal fo-=o ]])
	vim.cmd([[au FileType * set softtabstop=0 ]])
	vim.cmd([[au FileType * set noexpandtab ]])
	vim.cmd([[au FileType * set shiftwidth=4 ]])
	-- TODO, vim.cmd([[au FileType systemverilog lua require('sv.init') ]])
	-- TODO, vim.cmd([[au FileType ruby lua require('ruby.init') ]])
	vim.cmd ([[au BufRead,BufNewFile *.svh set filetype=systemverilog]])
	vim.cmd ([[set guicursor=n-v-c-a-sm:blinkon200,i-ci-ve:ver25,r-cr-o:hor20]])
end

config.default = function()
	config.basicVimSettings();
	-- require('plugin')
	local l=string.len(path);
	local home =string.sub(path,2,l-string.len('/configs/init.lua'));
	package.path=package.path..string.format(";%s/configs/?.lua",home);
	package.path=package.path..string.format(";%s/plugins/?.lua",home);
	package.path=package.path..string.format(";%s/themes/?.lua",home);
	require('plugin').setup(home);
end

config.setupWithPacker=function()
	config.basicVimSettings();
	-- This file can be loaded by calling `lua require('plugins')` from your init.vim
	-- Only required if you have packer configured as `opt`
	vim.cmd [[packadd packer.nvim]]
	
	return require('packer').startup({function(use)
	  -- Packer can manage itself
	  use 'wbthomason/packer.nvim'
	
--	  -- Simple plugins can be specified as strings
--	  use 'rstacruz/vim-closer'
--	
--	  -- Lazy loading:
--	  -- Load on specific commands
--	  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
--	
--	  -- Load on an autocommand event
--	  use {'andymass/vim-matchup', event = 'VimEnter'}
--	
--	  -- Load on a combination of conditions: specific filetypes or commands
--	  -- Also run code after load (see the "config" key)
--	  use {
--	    'w0rp/ale',
--	    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
--	    cmd = 'ALEEnable',
--	    config = 'vim.cmd[[ALEEnable]]'
--	  }
--	
--	  -- Plugins can have dependencies on other plugins
--	  use {
--	    'haorenW1025/completion-nvim',
--	    opt = true,
--	    requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
--	  }
--	
--	  -- Plugins can also depend on rocks from luarocks.org:
--	  use {
--	    'my/supercoolplugin',
--	    rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
--	  }
--	
--	  -- You can specify rocks in isolation
--	  use_rocks 'penlight'
--	  use_rocks {'lua-resty-http', 'lpeg'}
--	
--	  -- Local plugins can be included
--	  -- use '~/projects/personal/hover.nvim'
--	
--	  -- Plugins can have post-install/update hooks
--	  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
--	
--	  -- Post-install/update hook with neovim command
--	  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
--	
--	  -- Post-install/update hook with call of vimscript function with argument
--	  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
--	
--	  -- Use specific branch, dependency and run lua file after load
--	  use {
--	    'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
--	    requires = {'kyazdani42/nvim-web-devicons'}
--	  }
--	
--	  -- Use dependency and run lua function after load
--	  use {
--	    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
--	    config = function() require('gitsigns').setup() end
--	  }
--	
--	  -- You can specify multiple plugins in a single call
--	  use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
--	
--	  -- You can alias plugin names
--	  use {'dracula/vim', as = 'dracula'}


	-- Simple plugins can be specified as strings
	use 'rstacruz/vim-closer'
	-- Lazy loading:
	-- Load on specific commands
	use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

	-- Load on an autocommand event
	use {'andymass/vim-matchup', event = 'VimEnter'}
	use {"akinsho/toggleterm.nvim", tag = '*'}

	-- Load on a combination of conditions: specific filetypes or commands
	-- Also run code after load (see the "config" key)
	use {
		'w0rp/ale',
		ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
		cmd = 'ALEEnable',
		config = 'vim.cmd[[ALEEnable]]'
	}

  -- Plugins can have dependencies on other plugins
  use {
    'haorenW1025/completion-nvim',
    opt = true,
    requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  }

  -- Plugins can also depend on rocks from luarocks.org:
  -- use {
  --   'my/supercoolplugin',
  --   rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
  -- }

  -- You can specify rocks in isolation
  use_rocks 'penlight'
  use_rocks {'lua-resty-http', 'lpeg'}

  -- Local plugins can be included
  -- use '~/projects/personal/hover.nvim'

  -- Plugins can have post-install/update hooks
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- Post-install/update hook with neovim command
  -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Post-install/update hook with call of vimscript function with argument
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  -- You can specify multiple plugins in a single call
  use {'tjdevries/colorbuddy.vim'}
  -- Use specific branch, dependency and run lua file after load
  -- use {
  --   'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
  --   requires = {'kyazdani42/nvim-web-devicons'}
  -- }

  -- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }


	use {'dracula/vim', as = 'dracula'}

	-- add extra plugins here
	-- @RyanH, add cmp packers
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-cmdline"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-nvim-lua"
	use "saadparwaiz1/cmp_luasnip"
	use "rafamadriz/friendly-snippets"
	use "L3MON4D3/LuaSnip"
	-- use "f3fora/cmp-spell"
	-- to memory usage, use {
	-- to memory usage, 	"tzachar/cmp-tabnine",
	-- to memory usage, 	after = "nvim-cmp",
	-- to memory usage, 	run = "bash ./install.sh"
	-- to memory usage, }
	-- use {'neovim/nvim-lspconfig','williamboman/nvim-lsp-installer'}
	-- use {
	-- 	'autozimu/LanguageClient-neovim',
	-- 	run = 'bash ./install.sh'
	-- }

	-- @RyanH, add nord theme
	use 'shaunsingh/nord.nvim'
	use 'glepnir/zephyr-nvim'

	-- @RyanH, add nvim-tree
	-- TODO
	-- use {'kyazdani42/nvim-tree.lua',requires = 'kyazdani42/nvim-web-devicons'}
	-- @RyanH,bufferline
	use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
	use {
		'nvim-telescope/telescope.nvim', -- tag = '0.1.0',
		branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	-- use({
	-- 	"aserowy/tmux.nvim",
	-- 	config = function() require("tmux").setup() end
	-- })
	end,config={
		git={default_url_format='git@github.com:%s'}
	}
	})
end

config.setup = function(m)
	if m=='packer' then
		config.setupWithPacker();
	end
	config.default();
end


return config;
