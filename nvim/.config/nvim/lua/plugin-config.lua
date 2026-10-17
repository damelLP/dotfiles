-- Settings and keymaps for the non-LSP plugins

vim.env.FZF_DEFAULT_COMMAND = "rg --files"

-- Shorter CursorHold delay and a fixed sign column so diagnostics and
-- vim-signature marks don't shift the text sideways
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

vim.keymap.set("n", "<F1>", "<cmd>NERDTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<C-P>", "<cmd>Files<CR>", { silent = true })

-- Treesitter parsers are compiled locally, which needs the tree-sitter CLI
if vim.fn.executable("tree-sitter") == 1 then
  require("nvim-treesitter").install({
    "bash", "c", "cpp", "go", "json", "lua", "markdown", "markdown_inline",
    "python", "query", "rust", "toml", "vim", "vimdoc", "yaml",
  })
end

-- Use treesitter highlighting for any filetype that has a parser
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
