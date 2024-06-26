-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
    augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
    return
end

return packer.startup(function(use)
-- packer
    use("wbthomason/packer.nvim")

    -- lua functions that many plugins use
    use("nvim-lua/plenary.nvim")

    -- mason - managing and installing lsp servers
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    -- snippets
    use("L3MON4D3/LuaSnip") -- snippet engine
    use("saadparwaiz1/cmp_luasnip") -- for autocompletion
    use("rafamadriz/friendly-snippets") -- useful snippets

    -- autocompletion
    use("hrsh7th/nvim-cmp") -- completion plugin
    use("hrsh7th/cmp-buffer") -- source for text in buffer
    use("hrsh7th/cmp-path") -- source for file system paths

    -- lsp
    use('neovim/nvim-lspconfig')
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
    use("hrsh7th/cmp-nvim-lsp") -- for autocompletion

    -- color scheme
    --use("bluz71/vim-nightfly-guicolors")
    use{"catppuccin/nvim", as = "catppuccin"}

    -- file explorer
    use("nvim-tree/nvim-tree.lua")

    -- fuzzy finding w/ telescope
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

    -- copilot
    use("github/copilot.vim")

    -- vs-code like icons
    use("nvim-tree/nvim-web-devicons")

    -- airline
    use 'vim-airline/vim-airline'

    -- bufferline
    use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}

    -- surround with symbol
    use("tpope/vim-surround")

    -- comment
    use("scrooloose/nerdcommenter")

    -- hardtime - assists with good command workflow
    --use("m4xshen/hardtime.nvim")

    -- doge - documentation generator
    use {
        'kkoomen/vim-doge',
        run = ':call doge#install()'
    }

    -- reach
    -- buffer/mark/tabpage switcher
    use 'toppair/reach.nvim'

    -- autoclose 
    use("windwp/nvim-autopairs")

    -- git
    use ('TimUntersberger/neogit')

    -- dashboard
    use {
      'glepnir/dashboard-nvim',
      event = 'VimEnter',
      config = function()
        require('dashboard').setup {
          -- config
        }
      end,
      requires = {'nvim-tree/nvim-web-devicons'}
    }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }


    use {'neoclide/coc.nvim', branch = 'release'}


    if packer_bootstrap then
        require("packer").sync()
    end
end)
