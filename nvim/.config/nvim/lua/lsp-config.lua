local M = {}

function M.setup()
  -- Completion (nvim-cmp) using Neovim's built-in snippet engine
  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then cmp.select_next_item() else fallback() end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then cmp.select_prev_item() else fallback() end
      end, { "i", "s" }),
    }),
    sources = { { name = "nvim_lsp" } },
  })

  -- Defaults for every server; nvim-lspconfig supplies the per-server configs
  vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })

  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        diagnostics = { globals = { "vim" } },
      },
    },
  })

  vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = { border = "rounded" },
  })

  -- Mason downloads the servers into stdpath("data"); mason-lspconfig then
  -- calls vim.lsp.enable() for each one that's installed
  local servers = { "basedpyright", "clangd", "lua_ls", "rust_analyzer" }
  -- gopls is built with `go install`, so only ask for it once Go is present
  if vim.fn.executable("go") == 1 then
    table.insert(servers, "gopls")
  end

  require("mason").setup()
  require("mason-lspconfig").setup({ ensure_installed = servers })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
    callback = function(args)
      local function bmap(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
      end

      bmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
      bmap("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
      bmap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
      -- nowait so `gr` fires straight away instead of waiting to see if you
      -- meant one of Neovim's default grn/grr/gra/gri mappings
      vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references,
        { buffer = args.buf, nowait = true, desc = "References" })

      bmap("n", "[g", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
      bmap("n", "]g", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")

      bmap({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, "Code action")
      bmap("n", "<leader>qf", function()
        vim.lsp.buf.code_action({ context = { only = { "quickfix" } }, apply = true })
      end, "Apply quick fix")
      bmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
      bmap({ "n", "x" }, "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")
    end,
  })

  vim.api.nvim_create_user_command("Format", function() vim.lsp.buf.format() end, {})
end

return M
