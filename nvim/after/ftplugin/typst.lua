-- 2-wide tabs, spellcheck, soft wrap for prose
-- (tabs instead of spaces is set in after/indent/typst.lua)
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_gb"
vim.opt_local.wrap = true
vim.opt_local.linebreak = true  -- wrap at word boundaries, not mid-word
vim.opt_local.colorcolumn = ""
