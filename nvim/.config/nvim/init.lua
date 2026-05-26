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

-- jump to last used named buffer (skips [No Name] and empty buffers)
local function alt_named_buffer()
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    table.sort(bufs, function(a, b) return a.lastused > b.lastused end)
    local current = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(bufs) do
        if buf.bufnr ~= current and buf.name ~= "" then
            vim.cmd("buffer " .. buf.bufnr)
            return
        end
    end
    vim.notify("no other named buffer", vim.log.levels.INFO)
end
map("n", "<leader><leader>", alt_named_buffer, { desc = "last used buffer" })

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

-- ── LSP (one entry per language) ───────────────────────
-- install servers via apt / pipx / npm / cargo — see nvim/README.md
local function start_lsp(opts)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = opts.ft,
        callback = function()
            if vim.fn.executable(opts.cmd[1]) == 0 then return end
            local found = vim.fs.find(opts.root or { ".git" }, { upward = true })
            local root = found[1] and vim.fs.dirname(found[1]) or vim.fn.getcwd()
            vim.lsp.start({
                name = opts.name,
                cmd = opts.cmd,
                root_dir = root,
                settings = opts.settings,
            })
        end,
    })
end

-- the daily bread
start_lsp({ name = "gopls", ft = "go", cmd = { "gopls" },
           root = { "go.mod", ".git" } })

start_lsp({ name = "pyright", ft = "python",
           cmd = { "pyright-langserver", "--stdio" },
           root = { "pyproject.toml", "setup.py", ".git" } })

-- platform / infra languages
start_lsp({ name = "yamlls", ft = { "yaml", "yaml.ansible", "yaml.docker-compose" },
           cmd = { "yaml-language-server", "--stdio" },
           settings = {
               yaml = {
                   keyOrdering = false,
                   format = { enable = true },
                   schemas = {
                       ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
                       ["https://json.schemastore.org/github-action.json"]   = ".github/actions/*",
                       ["https://json.schemastore.org/ansible-playbook.json"] = { "playbook*.yml", "*-playbook.yml" },
                       ["https://json.schemastore.org/kustomization.json"]    = "kustomization.{yml,yaml}",
                       ["https://json.schemastore.org/docker-compose.json"]   = "docker-compose*.{yml,yaml}",
                       ["kubernetes"]                                         = "k8s/**/*.{yml,yaml}",
                   },
               },
           } })

start_lsp({ name = "bashls", ft = { "sh", "bash" },
           cmd = { "bash-language-server", "start" } })

start_lsp({ name = "taplo", ft = "toml",
           cmd = { "taplo", "lsp", "stdio" } })

start_lsp({ name = "jsonls", ft = { "json", "jsonc" },
           cmd = { "vscode-json-language-server", "--stdio" } })

start_lsp({ name = "terraformls", ft = { "terraform", "tf", "terraform-vars" },
           cmd = { "terraform-ls", "serve" },
           root = { ".terraform", ".git" } })

start_lsp({ name = "dockerls", ft = "dockerfile",
           cmd = { "docker-langserver", "--stdio" } })

start_lsp({ name = "marksman", ft = "markdown",
           cmd = { "marksman", "server" } })

start_lsp({ name = "lua_ls", ft = "lua",
           cmd = { "lua-language-server" },
           settings = {
               Lua = {
                   diagnostics = { globals = { "vim" } },
                   workspace = { checkThirdParty = false },
                   telemetry = { enable = false },
               },
           } })

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
