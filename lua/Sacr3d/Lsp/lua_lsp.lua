--[[=============================================]]--
--[[                     LSP                     ]]--
--[[          (Language Server Protocol)         ]]--
--[[=============================================]]--

--=>> Detect <<=--
-- local system_name
-- if fn.has('mac') == 1 then
-- 	system_name = 'macOS'
-- elseif fn.has('unix') == 1 then
-- 	system_name = 'Linux'
-- elseif fn.has('win32') == 1 then
-- 	system_name = 'Windows'
-- elseif fn.has('Android') == 1 then
-- 	system_name = 'Android'
-- else
-- 	print('Unsupported system for sumneko')
-- end

--=>> Settings <<=--
local nvim_lsp = require('lspconfig')
-- local fn = vim.fn
-- local coq = require('coq')

-- Set the path to the sumneko installation (ABSOLUTE PATH)
local sumneko_install_path = vim.fn.stdpath('data') .. '/lsp_servers/sumneko_lua/extension/server'
-- local sumneko_install_path = fn.stdpath('data') .. '/lspservers/lua-language-server'
local sumneko_binary = sumneko_install_path .. '/bin/Linux/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

--=>> Sumneko_Lua <<=-
nvim_lsp.sumneko_lua.setup({
  -- capabilities = coq.lsp_ensure_capabilities(vim.lsp.protocol.make_client_capabilities()),
	cmd = { sumneko_binary, '-E', sumneko_install_path .. '/main.lua' },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
    -- root_dir = function()
    --   vim.fn.getcwd()
    -- end,
	},
})

