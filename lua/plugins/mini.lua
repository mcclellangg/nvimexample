-- lua/plugins/mini.lua
return {
  enabled = true,
  'nvim-mini/mini.nvim', 
  version = '*',
  config = function()
    require("mini.statusline").setup({use_icons = true})
    require("mini.icons").setup({style = "glyph"})
    vim.cmd("colorscheme miniwinter")
  end
}
