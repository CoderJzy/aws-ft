vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' }
}
vim.lsp.config('pylsp', {
  cmd = {
    vim.fn.getcwd()..'/.venv/bin/pylsp'
  }
})
vim.lsp.enable('pylsp')
vim.opt.number = true
vim.opt.tabstop = 4
