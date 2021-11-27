--=>> Bashls <<=-
local nvim_lsp = require('lspconfig')

nvim_lsp.bashls.setup {
	cmd = { "bash-language-server", "start" },
	cmd_env = {
		GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)",
	},
	filetypes = { "sh", "bash", "zsh" },
	-- root_dir = "~"
}


