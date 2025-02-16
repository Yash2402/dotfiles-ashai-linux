vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use { 'lewis6991/gitsigns.nvim',
        config = function()
            require("gitsigns").setup()
        end,
    }
    use 'roxma/nvim-yarp'
    use 'norcalli/nvim-colorizer.lua'
    use 'roxma/vim-hug-neovim-rpc'
    use 'j-hui/fidget.nvim'
    use {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    }
    use {
        "gelguy/wilder.nvim",
        keys = { "/", ":", "?"},
        config = function()
            local wilder = require("wilder")
            local macchiato = require("catppuccin.palettes").get_palette("mocha")

            -- Create a highlight group for the popup menu
            local text_highlight =
                wilder.make_hl("WilderText",
                    { { a = 1 }, { a = 1 }, { background = "#00000000", foreground = macchiato.text } })
            local mauve_highlight =
                wilder.make_hl("WilderMauve",
                    { { a = 1 }, { a = 1 }, { background = "#00000000", foreground = macchiato.mauve } })

            -- Enable wilder when pressing :, / or ?
            wilder.setup({ modes = { ":", "/", "?"} })

            -- Enable fuzzy matching for commands and buffers
            wilder.set_option("pipeline", {
                wilder.branch(
                    wilder.cmdline_pipeline({
                        fuzzy = 1,
                    }),
                    wilder.vim_search_pipeline({
                        fuzzy = 1,
                    })
                ),
            })

            wilder.set_option(
                "renderer",
                wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
                    highlighter = wilder.basic_highlighter(),
                    highlights = {
                        default = text_highlight,
                        border = mauve_highlight,
                        accent = mauve_highlight,
                    },
                    pumblend = 5,
                    min_width = "100%",
                    min_height = "25%",
                    max_height = "25%",
                    border = "rounded",
                    left = { " ", wilder.popupmenu_devicons() },
                    right = { " ", wilder.popupmenu_scrollbar() },
                }))
            )
        end,
    }
    use({
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        -- or, branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    })
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            vim.cmd('colorscheme catppuccin')
        end
    })
    use { 'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    }
    use({ 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } })
    use 'nvim-treesitter/playground'
    use 'theprimeagen/harpoon'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'stevearc/oil.nvim'
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    -- install without yarn or npm
    use({ "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use({
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = {
                "markdown" }
        end,
        ft = { "markdown" },
    })
end)
