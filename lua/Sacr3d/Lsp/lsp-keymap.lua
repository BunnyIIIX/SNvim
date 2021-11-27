-- {{{ Helper
local function map(mode, bind, exec, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, bind, exec, opts)
end

local opt = {} --empty opt for maps with no extra options
local M = {}
-- }}}

-- {{{ Mappings.
local opts = { noremap = true, silent = true }
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map('n', '<space>R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', 'K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', '<space>k', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
map('n', '<space>{', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
map('n', '<space>}', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
map('n', '<M-q>', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- map('n', 'wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- map('n', 'wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- map('n', 'wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

--- Set some keybinds conditional on server capabilities
-- map('n', '<M-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- map('n', '<M-f>', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
-- }}}

return M

-- vim: set foldmethod=marker:
