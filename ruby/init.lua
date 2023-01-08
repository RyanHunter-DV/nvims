local rb={}


rb.cn = require('ruby.common')

vim.api.nvim_create_user_command('Def',function(args)
	rb.cn:defmethod(args.args)
	end,{force=true,nargs=1}
)
