vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' }
}
vim.pack.add{
  { src = 'https://github.com/mfussenegger/nvim-dap' }
}

vim.lsp.config('pylsp', {
  cmd = {
    vim.fn.getcwd()..'/.venv/bin/pylsp'
  }
})
vim.lsp.enable('pylsp')

vim.opt.number = true
vim.opt.tabstop = 4

local dap = require('dap')
dap.adapters.python = {
  type = 'executable',
  command = vim.fn.getcwd()..'/.venv/bin/python',
  args = {'-m', 'debugpy.adapter'}
}
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch File',
    program = '${file}',
    pythonPath = function()
      return vim.fn.getcwd()..'/.venv/bin/python'
    end
  }
}

vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function() require('dap.ui.widgets').hover() end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function() require('dap.ui.widgets').preview() end)
vim.keymap.set('n', '<Leader>df', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.frames) end)
vim.keymap.set('n', '<Leader>ds', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.scopes) end)
