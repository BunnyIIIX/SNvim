--[[================================================]]
--[[                   SEARCHBOX                    ]]
--[[================================================]]

-- {{{ Helper
local function map(mode, bind, exec, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, bind, exec, opts)
end

local opt = {} --empty opt for maps with no extra options
-- }}}

--{{{ Settings
require('searchbox').setup({
	popup = {
		relative = 'win',
		position = {
			row = '4%',
			col = '95%',
		},
		size = 30,
		border = {
			style = 'rounded',
			highlight = 'FloatBorder',
			text = {
				top = '💀 💀 💀',
				top_align = 'center',
				-- bottom = '💀',
				-- bottom_align = 'right',
			},
		},
		win_options = {
			winhighlight = 'Normal:Normal',
		},
	},
	hooks = {
		before_mount = function(input)
			-- code
		end,
		after_mount = function(input)
			-- code
		end,
	},
})
--}}}

--=>> KEYBINDS <<=
------------------
--{{{ Search
map(
	'n',
	"'",
	'<cmd>lua require("searchbox").match_all({clear_matches = true})<CR>',
	{ noremap = true, silent = true }
)

map(
	'v',
	"'",
	'<Esc><cmd>lua require("searchbox").match_all({clear_matches = true, visual_mode = true})<CR>',
	{ noremap = true, silent = true }
)

--> Make a reverse search, like the default `?`:
-- map('n', '/', '<cmd>lua require("searchbox").incsearch({reverse = true})<CR>', { noremap = true, silent = true })

--> Make the highlight of `match_all` go away after submit.
-- map('n', '/', '<cmd>lua require("searchbox").match_all({clear_matches = true})<CR>', { noremap = true, silent = true })

--> Move to the nearest exact match without any fuss.
-- map('n', '/', '<cmd>lua require("searchbox").simple({exact = true})<CR>', { noremap = true, silent = true })

--}}}

--{{{ Search and Replace
--> Confirm every match of search and replace
--> - Normal mode:
map(
	'n',
	'<Leader>r',
	'<cmd>lua require("searchbox").replace({exact = true, confirm = "menu"})<CR>',
	{ noremap = true, silent = true }
)
map(
	'n',
	'<M-r>',
	'<cmd>lua require("searchbox").replace({default_value = vim.fn.expand("<cword>"), confirm = "menu"})<CR>',
	{ noremap = true, silent = true }
)

--> - Visual mode:
-- map(
-- 	'v',
-- 	'<Leader>r',
-- 	'<Esc><cmd>lua require("searchbox").replace({exact = true, confirm = "menu", visual_mode = true})<CR>',
-- 	{ noremap = true, silent = true }
-- )
-- map(
-- 	'n',
-- 	'<Leader>R',
-- 	'<cmd>lua require("searchbox").replace({visual = true, default_value = vim.fn.expand("<cword>"), confirm = "menu"})<CR>',
-- 	{ noremap = true, silent = true }
-- )


--> Start a search and replace.
-- map('n', '<Leader>r', '<cmd>lua require("searchbox").replace()<CR>', { noremap = true, silent = true })

--> Replace an exact match in the selected text. (Visual mode)
-- map('v', '<Leader>r', '<Esc><cmd>lua require("searchbox").replace({exact = true, visual_mode = true})<CR>', { noremap = true, silent = true })

--}}}

-- # vim: foldmethod=marker:
