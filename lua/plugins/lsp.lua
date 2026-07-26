-- lua/plugins/lsp.lua
return {
  enabled = true,
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Enable vim globals, allowing for omni completion and other BANGER features
    -- Tells neovim about more lua stuff
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
	-- See the configuration section for more details
	-- Load luvit types when the `vim.uv` word is found
	{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  }
}
