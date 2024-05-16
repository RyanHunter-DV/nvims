local s={};
s.setup=function(home)
	package.path=package.path..string.format(";%s/plugins/telescope.nvim/lua/?.lua",home);
	package.path=package.path..string.format(";%s/plugins/telescope.nvim/lua/?/init.lua",home);
	package.path=package.path..string.format(";%s/plugins/telescope.nvim/plenary.nvim/lua/?.lua",home);
	package.path=package.path..string.format(";%s/plugins/telescope.nvim/plenary.nvim/lua/?/init.lua",home);

	local builtin = require('telescope.builtin')
	
	-- builtin.live_grep({
	-- 	prompt_title = 'find string in open buffers...',
	-- 	grep_open_files = true
	-- })
	
	local livegrep = function()
		builtin.live_grep({cwd='.'})
	end
	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	vim.keymap.set('n', '<leader>fg', livegrep,{})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	vim.api.nvim_create_user_command('Tsf',
		function(p)
			builtin.find_files({cwd=p.args})
		end,
		{
			force=true,
			nargs='*'
		}
	);
	vim.api.nvim_create_user_command('Tsg',
		function(p)
			builtin.live_grep({cwd=p.args})
		end,
		{
			force=true,
			nargs='*'
		}
	);
	
	require('telescope').setup{
	  defaults = {
	    -- Default configuration for telescope goes here:
	    -- config_key = value,
	    mappings = {
	      i = {
	        -- map actions.which_key to <C-h> (default: <C-/>)
	        -- actions.which_key shows the mappings for your picker,
	        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
	        ["<C-h>"] = "which_key"
	      }
	    }
	  },
	  pickers = {
	    -- Default configuration for builtin pickers goes here:
	    -- picker_name = {
	    --   picker_config_key = value,
	    --   ...
	    -- }
	    -- Now the picker_config_key will be applied every time you call this
	    -- builtin picker
	  },
	  extensions = {
	    -- Your extension configuration goes here:
	    -- extension_name = {
	    --   extension_config_key = value,
	    -- }
	    -- please take a look at the readme of the extension you want to configure
	  }
	}
end
return s;
