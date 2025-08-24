vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })

require("config.lazy")
vim.cmd.colorscheme "catppuccin"
-- TODO: Should I use vim.cmd or something else
-- TODO: configure catppuccin
-- TODO: configure treesitter
-- FIXME: telescope does not work properly see checkhealth telescope
