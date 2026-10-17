return {
  -- Theme and statusline
  { "nordtheme/vim", name = "nord-vim", priority = 1000 },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- Editing
  "preservim/nerdtree",
  "preservim/nerdcommenter",
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "kshenoy/vim-signature",
  "Yggdroot/indentLine",
  { "junegunn/fzf", build = "./install --bin" },
  "junegunn/fzf.vim",
  { "nvim-treesitter/nvim-treesitter", branch = "main", build = ":TSUpdate" },

  -- LSP and completion
  "neovim/nvim-lspconfig",
  "mason-org/mason.nvim",
  "mason-org/mason-lspconfig.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
}
