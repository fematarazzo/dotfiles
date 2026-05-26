-- Markdown is for reading. wrap on, spell on, conceal off.
vim.opt_local.wrap = true
vim.opt_local.linebreak = true            -- wrap at word boundaries
vim.opt_local.breakindent = true
vim.opt_local.spell = true
vim.opt_local.spelllang = "en,pt"
vim.opt_local.conceallevel = 0            -- show raw markup, don't lie about it
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.textwidth = 0               -- no hard wrap; let the renderer wrap

-- treat j/k as visual lines so wrapped text feels right
vim.keymap.set("n", "j", "gj", { buffer = true })
vim.keymap.set("n", "k", "gk", { buffer = true })
