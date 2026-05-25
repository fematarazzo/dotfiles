-- init.lua
-- Editor isn't a hobby. It's a tool. Minimal tooling.
-- No Lazy, no Packer, no Mason. Everything from apt or vendor/.

-- ── basics ─────────────────────────────────────────────
vim.opt.number = true
vim.opt.relativenumber = false   -- relative confuses me when I come back later
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.cache/nvim/undo")
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.mouse = ""               -- I don't use the mouse in the editor
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ── leader ─────────────────────────────────────────────
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ── personal mappings ──────────────────────────────────
local map = vim.keymap.set

-- save without thinking
map("n", "<leader>w", ":w<CR>", { desc = "save" })
map("n", "<leader>q", ":q<CR>", { desc = "quit" })

-- clear search
map("n", "<leader>h", ":nohlsearch<CR>", { desc = "clear highlight" })

-- file explorer (netrw — ships with nvim, no plugin needed)
map("n", "<leader>e", ":Explore<CR>", { desc = "explore" })

-- previous buffer
map("n", "<leader><leader>", "<C-^>", { desc = "alt buffer" })

-- window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- center after search
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- move lines (visual)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- ── netrw (built-in file explorer) ─────────────────────
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
vim.g.netrw_browse_split = 0

-- ── plugins (few, vendored) ────────────────────────────
-- in vendor/, installed manually once. updated every six months or so.
vim.opt.runtimepath:append("~/.config/nvim/vendor/vim-fugitive")
vim.opt.runtimepath:append("~/.config/nvim/vendor/vim-commentary")
vim.opt.runtimepath:append("~/.config/nvim/vendor/vim-surround")

-- ── LSP (only Go and Python — my daily bread) ──────────
-- gopls and pyright installed via system/pip
local function start_lsp(name, cmd, root_markers)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = name == "gopls" and "go" or "python",
        callback = function()
            local root = vim.fs.dirname(vim.fs.find(root_markers, { upward = true })[1])
            if root then
                vim.lsp.start({ name = name, cmd = cmd, root_dir = root })
            end
        end,
    })
end

start_lsp("gopls", { "gopls" }, { "go.mod", ".git" })
start_lsp("pyright", { "pyright-langserver", "--stdio" }, { "pyproject.toml", "setup.py", ".git" })

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gr", vim.lsp.buf.references, opts)
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "<leader>r", vim.lsp.buf.rename, opts)
        map("n", "<leader>a", vim.lsp.buf.code_action, opts)
        map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
    end,
})

-- ── format on save (Go) ────────────────────────────────
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function() vim.lsp.buf.format({ async = false }) end,
})

-- ── colorscheme ────────────────────────────────────────
-- habamax ships with nvim. calm, high contrast, no fuss.
vim.cmd.colorscheme("habamax")
