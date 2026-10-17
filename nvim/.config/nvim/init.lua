-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Leader has to be set before lazy.nvim loads so plugin mappings pick it up
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "nord" } },
  change_detection = { enabled = false },
  checker = { enabled = false },
})

require("plugin-config")
require("lsp-config").setup()
require("lualine").setup({ options = { theme = "nord" } })

vim.cmd("colorscheme nord")

-- nord-vim's Visual selection is too faint; use nord2 instead
vim.api.nvim_set_hl(0, "Visual", { ctermfg = "NONE", ctermbg = 0, bg = "#434c5e" })

--------------------------------------------------------------------------------
-- Editor options
--------------------------------------------------------------------------------
vim.opt.nrformats:append("alpha")
vim.opt.mouse = "a"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.number = true

vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.completeopt:append("longest")
vim.opt.hlsearch = false

vim.opt.splitbelow = true
vim.opt.splitright = true

--------------------------------------------------------------------------------
-- Relative numbers only in the focused buffer while in normal mode
--------------------------------------------------------------------------------
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  group = numbertoggle,
  command = "set relativenumber",
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  group = numbertoggle,
  command = "set norelativenumber",
})

--------------------------------------------------------------------------------
-- Copy mode: drop mouse, line numbers and indent guides for terminal selection
--------------------------------------------------------------------------------
local function toggle_copy_mode()
  if vim.o.mouse == "a" then
    vim.o.mouse = ""
    vim.o.relativenumber = false
    vim.o.number = false
  else
    vim.o.mouse = "a"
    vim.o.relativenumber = true
    vim.o.number = true
  end
  pcall(vim.cmd, "IndentLinesToggle")
end

vim.api.nvim_create_user_command("ToggleCopyMode", toggle_copy_mode, {})

--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>e", "<cmd>ToggleCopyMode<CR>", { silent = true })
vim.keymap.set("n", "<leader>bp", "<cmd>bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { silent = true })
