vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-lualine/lualine.nvim",
	"nvim-tree/nvim-web-devicons",
	"ellisonleao/gruvbox.nvim",
	"folke/zen-mode.nvim",
	"catgoose/nvim-colorizer.lua",
	"neovim/nvim-lspconfig",
})

local ok, treesitter = pcall(require, "nvim-treesitter")
if ok then
	treesitter.install({
		"c", "go", "rust", "html", "css",
		"javascript", "typst", "fish",
		"lua", "bash", "odin"
	})
end

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.colorcolumn = { 80, 100 }

-- Show tabs, spaces, and trailing whitespace
vim.opt.list = true
vim.opt.listchars = {
	tab = "→ ",
	trail = "•",
	space = "·",
	nbsp = "␣",
}

-- Theme
require("gruvbox").setup({
	contrast = "hard"
})
vim.cmd("colorscheme gruvbox")

-- Thin single-line border on all floating windows (hover, diagnostics, docs)
vim.o.winborder = "single"

vim.diagnostic.config({
	virtual_text = true,
	update_in_insert = true,
	float = { header = "" },
})

-- Keybindings
vim.keymap.set({"n", "v"}, "<leader>y", '"+y')
vim.keymap.set({"n", "v"}, "<leader>p", '"+p')

-- Lualine
require("lualine").setup({
	options = {
		section_separators = "",
		component_separators = "|",
	},
})

-- Treesitter: enable highlight per buffer
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})

vim.lsp.config("tinymist", { settings = { formatterMode = "typstyle" } })
vim.lsp.enable({
	"clangd", "gopls", "rust_analyzer", "julials",
	"html", "cssls", "ts_ls", "svelte", "tinymist",
	"slint_lsp", "ols"
})

-- LSP keybinds (attach only when LSP is active on buffer)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

		vim.lsp.completion.enable(true, args.data.client_id, args.buf)
		vim.bo[args.buf].autocomplete = true
		vim.bo[args.buf].complete = "o," .. vim.bo[args.buf].complete
	end,
})

-- Completion menu
vim.opt.completeopt = { "menuone", "noinsert", "fuzzy", "popup" }

-- Zen mode toggle
vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>")
require("zen-mode").setup({
	on_open = function(_win)
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.keymap.set("n", "j", "gj", { buffer = true })
		vim.keymap.set("n", "k", "gk", { buffer = true })
	end,
	on_close = function()
		vim.keymap.del("n", "j", { buffer = true })
		vim.keymap.del("n", "k", { buffer = true })
	end,
})

-- Colorizer
require("colorizer").setup({
	filetypes = {
		"*",
		css = { parsers = { css = true } },
	},
})

-- Stuff to get neovim to use actual tabs in rust files
vim.g.rust_recommended_style = false

-- Other keybinds:
vim.keymap.set('x', '<leader>a', ':!column -t -s= -o=<CR>', { desc = 'Align on =' })
