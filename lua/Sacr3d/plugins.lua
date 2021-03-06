require('packer').startup({

  --{{{ =>> Packer Config
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config')
      .. '/lua/Sacr3d/packer_compiled.lua',
  },
  display = {
    open_fn = require('packer.util').float,
  },
  --}}}

  --{{{ =>> Packer self management
  function(use)
    use('wbthomason/packer.nvim')
    --}}}

    --{{{ =>> Speedz Speedz Speedz
    --->> Impatient = Speed, Speed, Speed
    use({
      'lewis6991/impatient.nvim',
      config = function()
        require('impatient')
      end,
    })
    --}}}

    --{{{ =>> Lsp/Autocompletion/Snippets
    -- Lsp Plugins
    use({
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
    })
    use('onsails/lspkind-nvim')

    --->> Autocompletion
    use({
      'hrsh7th/nvim-cmp',
      requires = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-buffer' },
        -- {
        -- 	'tzachar/cmp-tabnine',
        -- 	run = './install.sh',
        -- },
      },
    })

    --->> Snippets
    use('hrsh7th/cmp-vsnip')
    use({
      'hrsh7th/vim-vsnip',
      requires = 'rafamadriz/friendly-snippets',
    })
    -- use('sirver/ultisnips')
    -- use('quangnguyen30192/cmp-nvim-ultisnips')

    --->> Coq-Nvim
    -- use({
    -- 	'ms-jpq/coq_nvim',
    -- 	branch = 'coq',
    -- 	config = function()
    -- 		require('Sacr3d.Goodies.coqnvim')
    -- 	end,
    -- 	requires = {
    -- 		'ms-jpq/coq.artifacts',
    -- 		branch = 'artifacts',
    -- 	},
    -- })

    --}}}

    --{{{ =>> UI / Themes
    --->> Statusline
    use({
      'nvim-lualine/lualine.nvim',
      requires = {
        'kyazdani42/nvim-web-devicons',
        opt = true,
      },
    })

    --->> Statusbar
    use('kdheepak/tabline.nvim')
    --}}}

    --{{{ =>> Improved Syntax Plugins
    --->> TreeSitter
    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
    })
    --->> Color Highlight
    use('norcalli/nvim-colorizer.lua')
    --->> Bookmarks
    use('glepnir/dashboard-nvim')
    --}}}

    --{{{ =>> Explorer
    --->> Telescope
    use({
      'nvim-telescope/telescope.nvim',
      requires = {
        { 'nvim-lua/popup.nvim' },
        { 'nvim-lua/plenary.nvim' },
      },
    })
    use({
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    })
    --->> NvimTree
    use({
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
    })

    --->> Better Quick Fix
    use({
      'kevinhwang91/nvim-bqf',
      -- ft = 'qf',
      -- requires = 'junegunn/fzf',
      -- run = function()
      -- 	vim.fn['fzf#install']()
      -- end,
    })

    --->> FZF
    use({
      'junegunn/fzf',
      run = function()
        vim.fn['fzf#install']()
      end,
    })
    --}}}

    --{{{ =>> Utility Plugins
    use('windwp/nvim-autopairs')
    use('terrortylor/nvim-comment')
    use('sbdchd/neoformat')
    use('phaazon/hop.nvim')

    --->> VimWiki
    use({
      'vimwiki/vimwiki',
      -- config = function()
      -- require("Sacr3d.Goodies.vimwiki")
      -- end,
    })

    --->> Mkdnflow.nvim
    -- use({
    -- 'jakewvincent/mkdnflow.nvim',
    -- config = function()
    -- require('mkdnflow').setup({
    -- 	-- Config goes here; leave blank for defaults
    -- })
    -- end,
    -- })

    --->> Smooth Scrolling
    use({
      'karb94/neoscroll.nvim',
    })

    --->> Title & Frame (With treesitter support)
    use({
      's1n7ax/nvim-comment-frame',
      requires = 'nvim-treesitter',
    })

    --->> Vim-Sandwich
    use('machakann/vim-sandwich')

    --->> Easy Replace
    use('andy-kwei/vim-easy-replace')

    --->> Vim-Repeat
    use('tpope/vim-repeat')

    --->> Cursor Effects
    use('edluffy/specs.nvim')

    --->> Reload Neovim Without Exit
    use('famiu/nvim-reload')

    --->> SearchBox
    use({
      'VonHeikemen/searchbox.nvim',
      -- config = function()
      -- 	require('Sacr3d.Goodies.search-box')
      -- end,
      requires = {
        { 'MunifTanjim/nui.nvim' },
      },
    })

    --->> GitSigns
    -- use({
    -- 	'lewis6991/gitsigns.nvim',
    -- 	requires = { 'nvim-lua/plenary.nvim' },
    -- })

    --->> Folding-Nvim
    -- use({
    -- 	'pierreglaser/folding-nvim',
    -- })
    --->> CleanFold
    -- use({
    -- 	'lewis6991/cleanfold.nvim',
    -- 	config = function()
    -- 		require('cleanfold').setup()
    -- 	end,
    -- })

    --->> Neorg
    -- use({
    -- 	'nvim-neorg/neorg',
    -- 	-- after = 'nvim-treesitter',
    -- 	requires = 'nvim-lua/plenary.nvim',
    -- })

    --->> Orgmode-nvim
    -- use({
    -- 	'kristijanhusak/orgmode.nvim',
    -- 	config = function()
    -- 		require('orgmode').setup({})
    -- 	end,
    -- })
    --}}}

    --{{{ =>> Themes
    -- popular themes incoming
    use('BunnyIIIX/sacr3d-nvim')
    use('joshdick/onedark.vim')
    use('sickill/vim-monokai')
    use('morhetz/gruvbox')
    use('shaunsingh/nord.nvim')
    use('sainnhe/gruvbox-material')

    -- Neesh Themes
    use('sainnhe/everforest')
    use('relastle/bluewery.vim')
    use('haishanh/night-owl.vim')
    --}}}

    --{{{ =>> Packer Config
  end,
  -- Display packer dialouge in the center in a floating window
  -- config = {
  -- display = {
  -- 	open_fn = require('packer.util').float,
  -- },
  -- 	compile_path = vim.fn.stdpath('config')
  -- 		.. '/lua/Sacr3d/packer_compiled.lua',
  -- },
})
--}}}

-- # vim: foldmethod=marker:
