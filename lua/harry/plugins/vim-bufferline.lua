-- Enable vim-bufferline
vim.g.bufferline = {
  auto_hide = false,
  animation = false,
  icons = true,
}

-- Set the tabline to display bufferline
vim.cmd('set showtabline=2')
vim.cmd('set tabline=%!BufferlineTabline()')

