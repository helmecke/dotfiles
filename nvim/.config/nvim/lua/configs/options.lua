local indent = 4

vim.bo.expandtab = true
vim.bo.shiftwidth = indent
vim.bo.smartindent = true
vim.bo.tabstop = indent

vim.o.autowrite = true
vim.o.swapfile = false
vim.o.confirm = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.listchars = 'tab:» ,extends:›,precedes:‹,nbsp:·,trail:·,eol:¬'
vim.o.hidden = true
vim.o.scrolloff = 3
vim.o.showbreak = '﬌ '
vim.o.showmatch = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.wildmode = 'list:longest,full'
vim.o.termguicolors = true
-- vim.o.spellfile = '~/.config/nvim/spell/en.utf-8.add,~/.config/nvim/spell/de.utf-8.add,~/.config/nvim/spell/names.utf-8.add'
-- vim.o.spelllang = 'en_us,de_de,names'

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.colorcolumn = '80'
vim.wo.cursorline = true
vim.wo.list = true
