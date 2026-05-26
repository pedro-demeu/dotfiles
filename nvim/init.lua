-- Ativar numeração de linhas
vim.opt.number = true
vim.opt.relativenumber = true

-- Melhor navegação
vim.opt.mouse = "a" 
vim.opt.clipboard = "unnamedplus"

-- Espaços e indentação
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Pesquisa inteligente
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- Plugins básicos via packer
-- Instale packer primeiro: https://github.com/wbthomason/packer.nvim
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
end)

-- Ativar LSP para JavaScript/TypeScript
require('lspconfig').tsserver.setup{}

