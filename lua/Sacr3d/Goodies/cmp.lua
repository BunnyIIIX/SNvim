-- Setup nvim-cmp.
local cmp = require('cmp')
local lspkind = require('lspkind')
local keymap = require('Sacr3d.Setting.keymaps')

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0
		and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
				:sub(col, col)
				:match('%s')
			== nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(
		vim.api.nvim_replace_termcodes(key, true, true, true),
		mode,
		true
	)
end

local source_mapping = {
	buffer = '[Buffer]',
	nvim_lsp = '[LSP]',
	nvim_lua = '[Lua]',
	cmp_tabnine = '[TN]',
	path = '[Path]',
}

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn['vsnip#anonymous'](args.body)
		end,
	},
	-- mapping = keymap.cmp_mappings,
	mapping = {
		-- ['<Up>'] = cmp.mapping.select_prev_item({
		-- 	behavior = cmp.SelectBehavior.Select,
		-- }),
		-- ['<Down>'] = cmp.mapping.select_next_item({
		-- 	behavior = cmp.SelectBehavior.Select,
		-- }),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		-- Right is for ghost_text to behave like terminal
		-- ['<Right>'] = cmp.mapping.confirm({ select = true }),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn['vsnip#available']() == 1 then
				feedkey('<Plug>(vsnip-expand-or-jump)', '')
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, {
			'i',
			's',
		}),

		['<S-Tab>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn['vsnip#jumpable'](-1) == 1 then
				feedkey('<Plug>(vsnip-jump-prev)', '')
			end
		end, {
			'i',
			's',
		}),
	},
	experimental = {
		ghost_text = true,
	},
	documentation = {
		border = {
			'???',
			'???',
			'???',
			'???',
			'???',
			'???',
			'???',
			'???',
		},
	},
	sources = {
		-- 'crates' is lazy loaded
		{ name = 'nvim_lsp', priority = 1 },
		{ name = 'path' },
		{ name = 'vsnip' },
		-- { name = 'treesitter' },
		-- { name = 'cmp_tabnine' },
		-- { name = 'orgmode ' },
		-- { name = 'neorg' },
		{
			name = 'buffer',
			options = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		-- { name = 'spell' },
	},
	formatting = {
		-- 	format = function(entry, vim_item)
		-- 		vim_item.kind = string.format(
		-- 			'%s %s',
		-- 			lspkind.presets.default[vim_item.kind],
		-- 			vim_item.kind
		-- 		)
		-- 		vim_item.menu = ({
		-- 			nvim_lsp = '???',
		-- 			nvim_lua = '???',
		-- 			treesitter = '???',
		-- 			path = '???',
		-- 			buffer = '???',
		-- 			zsh = '???',
		-- 			vsnip = '???',
		-- 			spell = '???',
		-- 		})[entry.source.name]
		-- 		return vim_item
		-- 	end,
		-- },
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			if entry.source.name == 'cmp_tabnine' then
				if
					entry.completion_item.data ~= nil
					and entry.completion_item.data.detail ~= nil
				then
					menu = entry.completion_item.data.detail
						.. ' '
						.. menu
				end
				vim_item.kind = '???'
			end
			vim_item.menu = menu
			return vim_item
		end,
	},
})
