local lsp_installer = require('nvim-lsp-installer')

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {}

	-- (optional) Customize the options passed to the server
	-- if server.name == 'bashls' then
-- 	local nvim_lsp = require('lspconfig')
	-- 	nvim_lsp.bashls.setup({
	-- 		cmd = { 'bash-language-server', 'start' },
	-- 		cmd_env = {
	-- 			GLOB_PATTERN = '*@(.sh|.inc|.bash|.command)',
	-- 		},
	-- 		filetypes = { 'sh', 'bash', 'zsh' },
	-- 		-- root_dir = "~"
	-- 	})
	-- end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

-- vim.api.nvim_exec(
-- 	[[
-- augroup lsp_document_highlight
-- autocmd! * <buffer>
-- autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
-- autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
-- augroup END
-- ]],
-- 	false
-- )
