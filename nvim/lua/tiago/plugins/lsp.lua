-- LSP server configuration, capabilities, and keymaps.
-- Loaded by lazy.nvim after mason and mason-lspconfig have ensured servers are installed.
-- Keymaps are set per-buffer via LspAttach so they only exist where an LSP is active.

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.lsp.config("ts_ls", { capabilities = capabilities })
vim.lsp.config("html", { capabilities = capabilities })
vim.lsp.config("cssls", { capabilities = capabilities })
vim.lsp.config("jsonls", { capabilities = capabilities })

vim.lsp.enable({ "ts_ls", "html", "cssls", "jsonls" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local opts = { buffer = buf, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  end,
})
