-- vim: foldmethod=marker:foldlevel=0,ts=2 sts=2 sw=2 et
local M = {}

function M.setup()
    local api = vim.api

    -- Indicate first time installation
    local packer_bootstrap = false

    -- packer.nvim configuration
    local conf = {
        profile = {
        enable = true,
        threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
        },

        display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
        },
    }

    -- Check if packer.nvim is installed
    -- Run PackerCompile if there are changes in this file
    local function packer_init()
        local fn = vim.fn
        local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
        if fn.empty(fn.glob(install_path)) > 0 then
            packer_bootstrap = fn.system {
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path,
            }
            vim.cmd [[packadd packer.nvim]]
        end
        vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    end

    local function plugins()
        use { "wbthomason/packer.nvim" }

        -- Performance
        use { "lewis6991/impatient.nvim" }
    
        -- Load only when require
        use { "nvim-lua/plenary.nvim", module = "plenary" }

        -- Notification
        use {
            "rcarriga/nvim-notify",
            event = "VimEnter",
            config = function()
                vim.notify = require "notify"
            end,
        }

        -- Colour Schemes {{{
        use {
            "sainnhe/sonokai",
            config = function()
                vim.cmd "colorscheme andromeda"
            end,
            disable = false,
        }
        use {
            "folke/tokyonight.nvim",
            config = function()
                vim.cmd "colorscheme tokyonight"
            end,
            disable = true,
        }
        use {
            "sainnhe/everforest",
            config = function()
                vim.cmd "colorscheme everforest"
            end,
            disable = true,
        }
        use {
            "sainnhe/gruvbox-material",
            config = function()
                vim.cmd "colorscheme gruvbox-material"
            end,
            disable = true,
        }
        -- }}} Colour Schemes

        -- Startup screen
        use {
            "goolord/alpha-nvim",
            config = function()
              require("config.alpha").setup()
            end,
        }

        -- Git {{{
        use {
            "TimUntersberger/neogit",
            cmd = "Neogit",
            config = function()
                require("config.neogit").setup()
            end,
        }
        use {
            "lewis6991/gitsigns.nvim",
            event = "BufReadPre",
            wants = "plenary.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("config.gitsigns").setup()
            end,
        }
        use {
            "tpope/vim-fugitive",
            cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
            requires = { "tpope/vim-rhubarb" },
            -- wants = { "vim-rhubarb" },
        }
        use {
            "ruifm/gitlinker.nvim",
            requires = "nvim-lua/plenary.nvim",
            module = "gitlinker",
            config = function()
                require("gitlinker").setup { mappings = nil }
            end,
        }
        use {
            "pwntester/octo.nvim",
            cmd = "Octo",
            wants = { "telescope.nvim", "plenary.nvim", "nvim-web-devicons" },
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim",
                "kyazdani42/nvim-web-devicons",
            },
            config = function()
                require("octo").setup()
            end,
            disable = true,
        }
        -- }}} Git

        -- WhichKey
        use {
            "folke/which-key.nvim",
            event = "VimEnter",
            config = function()
                require("config.whichkey").setup()
            end,
        }

        -- IndentLine
        use {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufReadPre",
            config = function()
                require("config.indentblankline").setup()
            end,
        }

        -- Better icons
        use {
            "kyazdani42/nvim-web-devicons",
            module = "nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup { default = true }
            end,
        }

        -- Better Comment
        use {
            "numToStr/Comment.nvim",
            keys = { "gc", "gcc", "gbc" },
            config = function()
                require("config.comment").setup()
            end,
        }

        -- Better surround
        use { "tpope/vim-surround", event = "InsertEnter" }

        -- Motions
        use { "andymass/vim-matchup", event = "CursorMoved" }
        use { "wellle/targets.vim", event = "CursorMoved" }
        use { "unblevable/quick-scope", event = "CursorMoved", disable = false }
        use { "chaoren/vim-wordmotion", opt = true, fn = { "<Plug>WordMotion_w" } }

        -- Buffer
        use { "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } }

        -- IDE {{{
        use {
            "antoinemadec/FixCursorHold.nvim",
            event = "BufReadPre",
            config = function()
                vim.g.cursorhold_updatetime = 100
            end,
        }
        use {
            "max397574/better-escape.nvim",
            event = { "InsertEnter" },
            config = function()
                require("better_escape").setup {
                    mapping = { "jk" },
                    timeout = vim.o.timeoutlen,
                    keys = "<ESC>",
                }
            end,
        }
        use {
            "karb94/neoscroll.nvim",
            event = "BufReadPre",
            config = function()
                require("config.neoscroll").setup()
            end,
            disable = true,
        }
        -- }}} IDE

        -- Code documentation
        use {
            "danymat/neogen",
            config = function()
                require("neogen").setup {}
            end,
            cmd = { "Neogen" },
        }

        use {
            "phaazon/hop.nvim",
            cmd = { "HopWord", "HopChar1" },
            config = function()
              require("hop").setup {}
            end,
            disable = true,
        }
        use {
            "ggandor/lightspeed.nvim",
            keys = { "s", "S", "f", "F", "t", "T" },
            config = function()
                require("lightspeed").setup {}
            end,
        }

        -- Markdown
        use {
            "iamcco/markdown-preview.nvim",
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
            ft = "markdown",
            cmd = { "MarkdownPreview" },
        }

        -- Status line
        use {
            "nvim-lualine/lualine.nvim",
            event = "VimEnter",
            after = "nvim-treesitter",
            config = function()
                require("config.lualine").setup()
            end,
            wants = "nvim-web-devicons",
        }
        use {
            "SmiteshP/nvim-gps",
            requires = "nvim-treesitter/nvim-treesitter",
            module = "nvim-gps",
            wants = "nvim-treesitter",
            config = function()
                require("nvim-gps").setup()
            end,
        }

        -- Treesitter {{{
        use {
            "nvim-treesitter/nvim-treesitter",
            opt = true,
            event = "BufRead",
            run = ":TSUpdate",
            config = function()
                require("config.treesitter").setup()
            end,
            requires = {
                { "nvim-treesitter/nvim-treesitter-textobjects" },
                "windwp/nvim-ts-autotag",
                "JoosepAlviste/nvim-ts-context-commentstring",
            },
        }
        -- }}} Treesitter

        if PLUGINS.fzf_lua.enabled then
            -- FZF
            use { "junegunn/fzf", run = "./install --all", event = "VimEnter", disable = true } -- You don't need to install this if you already have fzf installed
            use { "junegunn/fzf.vim", event = "BufEnter", disable = true }
      
            -- FZF Lua
            use {
              "ibhagwan/fzf-lua",
              event = "BufEnter",
              wants = "nvim-web-devicons",
              requires = { "junegunn/fzf", run = "./install --all" },
            }
        end

        if PLUGINS.telescope.enabled then
            use {
                "nvim-telescope/telescope.nvim",
                opt = true,
                config = function()
                    require("config.telescope").setup()
                end,
                cmd = { "Telescope" },
                module = { "telescope", "telescope.builtin" },
                keys = { "<leader>f", "<leader>p", "<leader>z" },
                wants = {
                    "plenary.nvim",
                    "popup.nvim",
                    "telescope-fzf-native.nvim",
                    "telescope-project.nvim",
                    "telescope-repo.nvim",
                    "telescope-file-browser.nvim",
                    "project.nvim",
                    "trouble.nvim",
                    "telescope-dap.nvim",
                },
                requires = {
                    "nvim-lua/popup.nvim",
                    "nvim-lua/plenary.nvim",
                    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
                    "nvim-telescope/telescope-project.nvim",
                    "cljoly/telescope-repo.nvim",
                    "nvim-telescope/telescope-file-browser.nvim",
                    {
                        "ahmedkhalf/project.nvim",
                        config = function()
                            require("project_nvim").setup {}
                        end,
                    },
                    "nvim-telescope/telescope-dap.nvim",
                },
            }
        end

        -- nvim-tree
        use {
            "kyazdani42/nvim-tree.lua",
            opt = true,
            wants = "nvim-web-devicons",
            cmd = { "NvimTreeToggle", "NvimTreeClose" },
            module = "nvim-tree",
            config = function()
                require("config.nvimtree").setup()
            end,
        }

        -- Buffer line
        use {
            "akinsho/nvim-bufferline.lua",
            event = "BufReadPre",
            wants = "nvim-web-devicons",
            config = function()
                require("config.bufferline").setup()
            end,
        }

        -- User interface
        use {
            "stevearc/dressing.nvim",
            event = "BufReadPre",
            config = function()
                require("dressing").setup {
                    select = {
                        backend = { "telescope", "fzf", "builtin" },
                    },
                }
            end,
            disable = false,
        }

        -- Completion
        use {
            "ms-jpq/coq_nvim",
            branch = "coq",
            event = "VimEnter",
            opt = true,
            run = ":COQdeps",
            config = function()
                require("config.coq").setup()
            end,
            requires = {
                { "ms-jpq/coq.artifacts", branch = "artifacts" },
                { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
            },
            disable = not PLUGINS.coq.enabled,
        }
        
        use {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            opt = true,
            config = function()
                require("config.cmp").setup()
            end,
            wants = { "LuaSnip" },
            requires = {
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-nvim-lua",
                "ray-x/cmp-treesitter",
                "hrsh7th/cmp-cmdline",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lsp-signature-help",
                -- "onsails/lspkind-nvim",
                -- "hrsh7th/cmp-calc",
                -- "f3fora/cmp-spell",
                -- "hrsh7th/cmp-emoji",
                {
                    "L3MON4D3/LuaSnip",
                    wants = { "friendly-snippets", "vim-snippets" },
                    config = function()
                        require("config.snip").setup()
                    end,
                },
                "rafamadriz/friendly-snippets",
                "honza/vim-snippets",
            },
            disable = not PLUGINS.nvim_cmp.enabled,
        }

        -- Auto pairs
        use {
            "windwp/nvim-autopairs",
            wants = "nvim-treesitter",
            module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
            config = function()
                require("config.autopairs").setup()
            end,
        }

    -- Auto tag
        use {
            "windwp/nvim-ts-autotag",
            wants = "nvim-treesitter",
            event = "InsertEnter",
            config = function()
                require("nvim-ts-autotag").setup { enable = true }
            end,
        }
    
        -- End wise
        use {
            "RRethy/nvim-treesitter-endwise",
            wants = "nvim-treesitter",
            event = "InsertEnter",
            disable = false,
        }
  

        -- git setup in nvim
        use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
        
        -- Automatic tags management
        use 'ludovicchabant/vim-gutentags'

        -- Additional textobjects for treesitter
        use 'nvim-treesitter/nvim-treesitter-textobjects'

        -- LSP {{{
        use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
        -- }}} LSP

        use 'L3MON4D3/LuaSnip' -- Snippets plugin
        -- }}} Packages
    end

    -- Init and start packer
    packer_init()
    local packer = require "packer"

    -- Performance
    pcall(require, "impatient")
    -- pcall(require, "packer_compiled")

    packer.init(conf)
    packer.startup(plugins)

    -- Misc functions {{{
    -- Functional wrapper for mapping custom keybindings
    function map(mode, lhs, rhs, opts)
        local options = { noremap = true }
        if opts then
            options = vim.tbl_extend("force", options, opts)
        end
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end
    -- }}} Misc functions

    --Set highlight on search
    vim.o.hlsearch = true

    --Make line numbers default
    vim.wo.number = true

    --Enable mouse mode
    vim.o.mouse = 'a'

    --Enable break indent
    vim.o.breakindent = true

    --Save undo history
    vim.opt.undofile = true

    --Case insensitive searching UNLESS /C or capital in search
    vim.o.ignorecase = true
    vim.o.smartcase = true

    --Decrease update time
    vim.o.updatetime = 250
    vim.wo.signcolumn = 'yes'

    --Set colorscheme
    vim.o.termguicolors = true
    vim.cmd [[colorscheme onedark]]

    -- Set completeopt to have a better completion experience
    vim.o.completeopt = 'menuone,noselect'

    --Set statusbar
    require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
    },
    }

    --Remap space as leader key
    vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '

    --Remap for dealing with word wrap
    vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

    -- Highlight on yank
    local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
    api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
    })

    -- Telescope
    require('telescope').setup {
    defaults = {
        mappings = {
        i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
        },
        },
    },
    }

    -- Enable telescope fzf native
    require('telescope').load_extension 'fzf'

    --Add leader shortcuts
    vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers)
    vim.keymap.set('n', '<leader>sf', function()
    require('telescope.builtin').find_files { previewer = false }
    end)
    vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find)
    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags)
    vim.keymap.set('n', '<leader>st', require('telescope.builtin').tags)
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').grep_string)
    vim.keymap.set('n', '<leader>sp', require('telescope.builtin').live_grep)
    vim.keymap.set('n', '<leader>so', function()
    require('telescope.builtin').tags { only_current_buffer = true }
    end)
    vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)

    -- jk exits insert mode
    map("i", "jk", "<ESC>")
    map("n", ",<Space>", ":nohlsearch<CR>", { silent = true })
    -- map("n", "<Leader>", ":<C-u>WhichKey ','<CR>", { silent = true })
    -- map("n", "<Leader>?", ":WhichKey ','<CR>")
    -- map("n", "<Leader>a", ":cclose<CR>")

    -- Treesitter configuration
    -- Parsers must be installed manually via :TSInstall
    require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true, -- false will disable the whole extension
    },
    incremental_selection = {
        enable = true,
        keymaps = {
        init_selection = 'gnn',
        node_incremental = 'grn',
        scope_incremental = 'grc',
        node_decremental = 'grm',
        },
    },
    indent = {
        enable = true,
    },
    textobjects = {
        select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
        },
        },
        move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
        },
        goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
        },
        goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
        },
        goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
        },
        },
    },
    }

    -- Diagnostic keymaps
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

    -- LSP settings
    local lspconfig = require 'lspconfig'
    local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        vim.inspect(vim.lsp.buf.list_workspace_folders())
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
    api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
    end

    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    -- Enable the following language servers
    local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
    for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
    end

    -- Example custom server
    -- Make runtime files discoverable to the server
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
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
    },
    }

    -- luasnip setup
    local luasnip = require 'luasnip'

    -- nvim-cmp setup
    local cmp = require 'cmp'
    cmp.setup {
    snippet = {
        expand = function(args)
        luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    }

    -- nvim-tree config
    vim.cmd[[
    nnoremap <C-n> :NvimTreeToggle<CR>
    nnoremap <leader>r :NvimTreeRefresh<CR>
    nnoremap <leader>n :NvimTreeFindFile<CR>
    " More available functions:
    " NvimTreeOpen
    " NvimTreeClose
    " NvimTreeFocus
    " NvimTreeFindFileToggle
    " NvimTreeResize
    " NvimTreeCollapse
    " NvimTreeCollapseKeepBuffers

    set termguicolors " this variable must be enabled for colors to be applied properly
    ]]

    -- close NvimTree if last buffer open
    api.nvim_create_autocmd(
        "BufEnter",
        {command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"}
    )
    --
    -- open NvimTree in fresh start
    -- api.nvim_create_autocmd(
    --   "VimEnter",
    --   {command = "NvimTreeOpen | wincmd p"}
    -- )

    -- local wk = require("which-key")
    -- As an example, we will create the following mappings:
    --  * <leader>ff find files
    --  * <leader>fr show recent files
    --  * <leader>fb Foobar
    -- we'll document:
    --  * <leader>fn new file
    --  * <leader>fe edit file
    -- and hide <leader>1

    -- wk.register({
    -- ["w"] = { "<cmd>update!<CR>", "Save" },

    -- q = {
    --     name = "Quit",
    --     q = { "<cmd>q!<CR>", "Quit" },
    --     x = { "<cmd>x!<CR>", "Save & Quit" },
    -- },

    -- f = {
    --     name = "File", -- optional group name
    --     f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
    --     s = { "<cmd>update!<CR>", "Save" }, -- Save file
    --     r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap=false }, -- additional options for creating the keymap
    --     ["1"] = "which_key_ignore",  -- special label to hide it in the popup
    --     b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
    -- },

    -- b = {
    --     name = "Buffer",
    --     d = { "<Cmd>bd!<Cr>", "Close current buffer" },
    --     D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    -- },

    -- z = {
    --     name = "Packer",
    --     c = { "<cmd>PackerCompile<cr>", "Compile" },
    --     i = { "<cmd>PackerInstall<cr>", "Install" },
    --     s = { "<cmd>PackerSync<cr>", "Sync" },
    --     S = { "<cmd>PackerStatus<cr>", "Status" },
    --     u = { "<cmd>PackerUpdate<cr>", "Update" },
    -- },

    -- g = {
    --     name = "Git",
    --     s = { "<cmd>Neogit<CR>", "Status" },
    -- },
    -- }, { prefix = "<leader>" })
end