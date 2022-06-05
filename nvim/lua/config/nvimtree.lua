local M = {}

function M.setup()
  require("nvim-tree").setup {
    disable_netrw = false,
    hijack_netrw = true,
    respect_buf_cwd = true,
    view = {
      number = true,
      relativenumber = true,
    },
    filters = {
      custom = { ".git" },
    },
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
  }

  -- close NvimTree if last buffer open
  vim.api.nvim_create_autocmd(
    "VimEnter",
    {command = "NvimTreeOpen | wincmd p"}
  )
  -- close NvimTree if last buffer open
  vim.api.nvim_create_autocmd(
    "BufEnter",
    {command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"}
  )
end

return M