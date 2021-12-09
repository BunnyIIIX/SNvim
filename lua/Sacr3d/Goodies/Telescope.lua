-- https://github.com/nvim-telescope/telescope.nvim/issues/1048
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local custom_actions = {}
local previewers = require('telescope.previewers')
-- local builtin = require('telescope.builtin')
-- local themes = require('telescope.themes')

function custom_actions._multiopen(prompt_bufnr, open_cmd)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local num_selections = #picker:get_multi_selection()
	if num_selections > 1 then
		local cwd = picker.cwd
		if cwd == nil then
			cwd = ''
		else
			cwd = string.format('%s/', cwd)
		end
		vim.cmd('bw!') -- wipe the prompt buffer
		for _, entry in ipairs(picker:get_multi_selection()) do
			vim.cmd(
				string.format('%s %s%s', open_cmd, cwd, entry.value)
			)
		end
		vim.cmd('stopinsert')
	else
		if open_cmd == 'vsplit' then
			actions.file_vsplit(prompt_bufnr)
		elseif open_cmd == 'split' then
			actions.file_split(prompt_bufnr)
		elseif open_cmd == 'tabe' then
			actions.file_tab(prompt_bufnr)
		else
			actions.file_edit(prompt_bufnr)
		end
	end
end
function custom_actions.multi_selection_open_vsplit(
	prompt_bufnr
)
	custom_actions._multiopen(prompt_bufnr, 'vsplit')
end
function custom_actions.multi_selection_open_split(
	prompt_bufnr
)
	custom_actions._multiopen(prompt_bufnr, 'split')
end
function custom_actions.multi_selection_open_tab(prompt_bufnr)
	custom_actions._multiopen(prompt_bufnr, 'tabe')
end
function custom_actions.multi_selection_open(prompt_bufnr)
	custom_actions._multiopen(prompt_bufnr, 'edit')
end

local multi_mappings = {
	i = {
		['<esc>'] = actions.close,
		['<C-j>'] = actions.move_selection_next,
		['<C-k>'] = actions.move_selection_previous,
		['<tab>'] = actions.toggle_selection
			+ actions.move_selection_next,
		['<s-tab>'] = actions.toggle_selection
			+ actions.move_selection_previous,
		['<cr>'] = custom_actions.multi_selection_open,
		['<c-v>'] = custom_actions.multi_selection_open_vsplit,
		['<c-s>'] = custom_actions.multi_selection_open_split,
		['<c-t>'] = custom_actions.multi_selection_open_tab,
		-- ['<cr>'] = actions.file_edit,
	},
}

local default_mappings = {
	n = {
		-- ['<esc>'] = actions.close,
		['<C-j>'] = actions.move_selection_next,
		['<C-k>'] = actions.move_selection_previous,
		['<tab>'] = actions.toggle_selection
			+ actions.move_selection_next,
		['<s-tab>'] = actions.toggle_selection
			+ actions.move_selection_previous,
		-- ['<cr>'] = custom_actions.multi_selection_open,
		['<c-v>'] = custom_actions.multi_selection_open_vsplit,
		['<c-s>'] = custom_actions.multi_selection_open_split,
		['<c-t>'] = custom_actions.multi_selection_open_tab,
		['Q'] = actions.smart_add_to_qflist + actions.open_qflist,
		['q'] = actions.smart_send_to_qflist
			+ actions.open_qflist,
		-- ['<cr>'] = actions.file_edit,
		-- ['v'] = actions.file_vsplit,
		-- ['s'] = actions.file_split,
	},
}

local opts_cursor = {
	initial_mode = 'normal',
	sorting_strategy = 'ascending',
	layout_strategy = 'cursor',
	results_title = false,
	layout_config = {
		width = 0.5,
		height = 0.4,
	},
}

local opts_vertical = {
	initial_mode = 'normal',
	sorting_strategy = 'ascending',
	layout_strategy = 'drop_down',
	results_title = false,
	layout_config = {
		width = 0.3,
		height = 0.5,
		prompt_position = 'top',
		mirror = true,
	},
}

local new_maker = function(filepath, bufnr, opts)
	opts = opts or {}

	filepath = vim.fn.expand(filepath)
	vim.loop.fs_stat(filepath, function(_, stat)
		if not stat then
			return
		end
		if stat.size > 100000 then
			return
		else
			previewers.buffer_previewer_maker(filepath, bufnr, opts)
		end
	end)
end

require('telescope').setup({
	defaults = {
		layout_strategy = 'vertical',
		layout_config = {
			width = 50,
			height = 65,
		},
		prompt_prefix = '=> ',
		selection_caret = '=> ',
		dynamic_preview_title = true,
		entry_prefix = '   ',
		borderchars = {
			'═',
			'│',
			'═',
			'│',
			'╒',
			'╕',
			'╛',
			'╘',
		},
		buffer_previewer_maker = new_maker,
		file_ignore_patterns = {
			'.git/',
		},
		vimgrep_arguments = {
			'rg',
			'--ignore',
			'--hidden',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
	pickers = {
		buffers = {
			theme = 'dropdown',
			prompt_title = '✨ Search Buffers ✨',
			mappings = vim.tbl_deep_extend('force', {
				n = {
					['d'] = actions.delete_buffer,
				},
			}, default_mappings),
			sort_mru = true,
			preview_title = false,
		},
		lsp_code_actions = vim.tbl_deep_extend(
			'force',
			opts_cursor,
			{
				prompt_title = 'Code Actions',
			}
		),
		lsp_range_code_actions = vim.tbl_deep_extend(
			'force',
			opts_vertical,
			{
				prompt_title = 'Code Actions',
			}
		),
		lsp_document_diagnostics = vim.tbl_deep_extend(
			'force',
			opts_vertical,
			{
				prompt_title = 'Document Diagnostics',
				mappings = default_mappings,
			}
		),
		lsp_implementations = vim.tbl_deep_extend(
			'force',
			opts_cursor,
			{
				prompt_title = 'Implementations',
				mappings = default_mappings,
			}
		),
		lsp_definitions = vim.tbl_deep_extend(
			'force',
			opts_cursor,
			{
				prompt_title = 'Definitions',
				mappings = default_mappings,
			}
		),
		lsp_references = vim.tbl_deep_extend('force', opts_cursor, {
			prompt_title = 'References',
			mappings = default_mappings,
		}),
		find_files = {
			prompt_title = '✨ Find Files ✨',
			mappings = multi_mappings,
			hidden = true,
			theme = 'ivy',
			borderchars = {
				prompt = {
					'═',
					'│',
					'═',
					'│',
					'╒',
					'╕',
					'╛',
					'╘',
				},
				results = {
					'═',
					'│',
					'═',
					'│',
					'│',
					'│',
					'╛',
					'╘',
				},
				preview = {
					'═',
					'│',
					'═',
					'│',
					'╒',
					'╕',
					'╛',
					'╘',
				},
			},
		},
		file_browser = {
			prompt_title = '✨ File Browser ✨',
			mappings = default_mappings,
			hidden = true,
			theme = 'ivy',
			borderchars = {
				prompt = {
					'═',
					'│',
					'═',
					'│',
					'╒',
					'╕',
					'╛',
					'╘',
				},
				results = {
					'═',
					'│',
					'═',
					'│',
					'│',
					'│',
					'╛',
					'╘',
				},
				preview = {
					'═',
					'│',
					'═',
					'│',
					'╒',
					'╕',
					'╛',
					'╘',
				},
			},
		},
		git_files = {
			prompt_title = '✨ Search Git Project ✨',
			mappings = multi_mappings,
			hidden = true,
		},
		live_grep = {
			prompt_title = '✨ Live Grep ✨',
			mappings = default_mappings,
			-- hidden = true,
			theme = 'ivy',
			borderchars = {
				prompt = {
					'═',
					'│',
					'═',
					'│',
					'╒',
					'╕',
					'╛',
					'╘',
				},
				results = {
					'═',
					'│',
					'═',
					'│',
					'│',
					'│',
					'╛',
					'╘',
				},
				preview = {
					'═',
					'│',
					'═',
					'│',
					'╒',
					'╕',
					'╛',
					'╘',
				},
			},
		},
	},
})

require('telescope').load_extension('fzf')
