vim.api.nvim_exec([[
au filetype vimwiki silent! unmap <buffer> <Tab>
]])

-- Setup cmp setup buffer configuration - 👻 text off for markdown
-- local cmp = require('cmp')
-- cmp.setup.buffer({
-- 	sources = {
-- 		{ name = 'vsnip' },
-- 		{
-- 			name = 'buffer',
-- 			opts = {
-- 				get_bufnrs = function()
-- 					return vim.api.nvim_list_bufs()
-- 				end,
-- 			},
-- 		},
-- 		{ name = 'path' },
-- 		{ name = 'spell' },
-- 	},
-- 	experimental = {
-- 		ghost_text = true,
-- 	},
-- })

-- local opt = vim.opt

-- vim.opt_local.colorcolumn = '101'
-- opt.autoindent = true
-- opt.linebreak = true
-- @TODOUA:
-- spell is not staying local for some reason
-- have to set nospell in other fts that are opened after a markdown
-- vim.opt_local.spell = true
-- opt.conceallevel = 3
-- opt.foldmethod = 'manual'
-- vim.cmd [[set syntax=markdown]]
-- vim.b.vsnip_snippet_dir = "expand('~/.config/nvim/snippets/')"

-- vim.api.nvim_exec(
--   [[
-- " arrows
-- " iabbrev >> →
-- " iabbrev << ←
-- " iabbrev ^^ ↑
-- " iabbrev VV ↓
-- " eunuch map
-- " nmap <buffer><silent><localleader>rn :Rename<space>
-- " add selected as todoist text
-- " nmap <buffer><localleader>1 :!todoist add "" -N ""<left><left><left><left><left><left><left>
-- " snippets for markdown
-- let b:vsnip_snippet_dir = expand('~/.config/nvim/snippets/')
-- ]],
--   false
-- )

-- vim.api.nvim_exec(
-- 	[[
-- augroup PersistMarkdownFolds
--   autocmd!
--   autocmd BufWinLeave *.md mkview
--   autocmd BufWinEnter *.md silent! loadview
-- augroup end
-- ]],
-- 	false
-- )
