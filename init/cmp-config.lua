vim.api.nvim_set_option('completeopt','menu,menuone')
local cmp = require'cmp'
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
	formatting = {
		fields = {'kind','abbr','menu'},
		format = function(entry,vim_item)
			vim_item.kind = '-'
			vim_item.menu = ({
				-- nvim_lsp    = '[LSP]',
				-- too memory usage, cmp_tabnine = '[Tabnine]',
				buffer      = '[Buffer]',
				luasnip     = '[Snippet]',
				spell       = '[Spell]',
				-- path        = '[Path]',
				-- cmdline     = '[Cmdline]',
			})[entry.source.name]
			return vim_item
		end
	},
    sources = cmp.config.sources({
      -- { name = 'lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
      { name = 'path' },
      -- { name = 'cmdline' },
      { name = 'spell' },
      -- too memory usage, { name = 'cmp_tabnine' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{ name = 'buffer' },{ name = 'path' }}
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
	--sources = cmp.config.sources({{name='cmdline'},{name='path'}})
    sources = cmp.config.sources({
      --{ name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--   capabilities = capabilities
-- }

