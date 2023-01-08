require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
require'lspconfig'.pyright.setup{}
require'lspconfig'.solargraph.setup{}
-- require'lspconfig'.sorbet.setup{}
require'lspconfig'.svlangserver.setup{}
-- nvim-lsp-installer/servers/solargraph/init.lua
-- local servers = {
-- 	solargraph = require ''
-- }
-- lsp_installer.on_server_ready(function(server)
-- 	local opts = servers[server.name];
-- 	if opts then
-- 		server:setup(opts)
-- 	end
-- end)
