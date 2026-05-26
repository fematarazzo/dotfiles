-- YAML wants 2 spaces. Always. Don't fight it.
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.indentkeys:remove("0#")  -- don't unindent on '#'
