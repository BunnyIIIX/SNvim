-- ignore files that are larger than a certain size
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')

local default_mappings = {
  n = {
    ['Q'] = actions.smart_add_to_qflist + actions.open_qflist,
    ['q'] = actions.smart_send_to_qflist + actions.open_qflist,
    ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
    ['<s-tab>'] = actions.toggle_selection + actions.move_selection_previous,
    ['v'] = actions.file_vsplit,
    ['s'] = actions.file_split,
    ['<cr>'] = actions.file_edit,
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
  layout_strategy = 'vertical',
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
		prompt_prefix = '=> ',
		selection_caret = '=> ',
    dynamic_preview_title = true,
		entry_prefix = '   ',
		borderchars = { '═', '│', '═', '│', '╒', '╕', '╛', '╘' },
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
      prompt_title = '✨ Search Buffers ✨',
      mappings = vim.tbl_deep_extend('force', {
        n = {
          ['d'] = actions.delete_buffer,
        },
      }, default_mappings),
      sort_mru = true,
      preview_title = false,
    },
    lsp_code_actions = vim.tbl_deep_extend('force', opts_cursor, {
      prompt_title = 'Code Actions',
    }),
    lsp_range_code_actions = vim.tbl_deep_extend('force', opts_vertical, {
      prompt_title = 'Code Actions',
    }),
    lsp_document_diagnostics = vim.tbl_deep_extend('force', opts_vertical, {
      prompt_title = 'Document Diagnostics',
      mappings = default_mappings,
    }),
    lsp_implementations = vim.tbl_deep_extend('force', opts_cursor, {
      prompt_title = 'Implementations',
      mappings = default_mappings,
    }),
    lsp_definitions = vim.tbl_deep_extend('force', opts_cursor, {
      prompt_title = 'Definitions',
      mappings = default_mappings,
    }),
    lsp_references = vim.tbl_deep_extend('force', opts_cursor, {
      prompt_title = 'References',
      mappings = default_mappings,
    }),
    find_files = {
      prompt_title = '✨ Search Project ✨',
      mappings = default_mappings,
      hidden = true,
    },
    git_files = {
      prompt_title = '✨ Search Git Project ✨',
      mappings = default_mappings,
      hidden = true,
    },
    live_grep = {
      prompt_title = '✨ Live Grep ✨',
      mappings = default_mappings,
    },
  },
})

require('telescope').load_extension('fzf')
