-- lua/plugins/telescope.lua
return {
  enabled = true,
  "nvim-telescope/telescope.nvim",
  version = "0.2.2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    extensions = {
      fzf = {}
    }
  },

  opts = {
    pickers = {
      find_files = {
	theme = "ivy",
      },
    },
  },


  -- Where did I get this idea ?
  keys = {
    { "<space>fh", function() require("telescope.builtin").help_tags() end, desc = "Find help" },
    { "<space>fd", function() require("telescope.builtin").find_files() end, desc = "Find files" },
    {
      "<space>en",
      function()
	require("telescope.builtin").find_files({
	  cwd = vim.fn.stdpath("config"),
	})
      end,
      desc = "Edit Neovim config",
    },
    {
      "<space>ep",
      function ()
	require('telescope.builtin').find_files({
	  cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
	})
      end,
      desc = "Edit Neovim packages",
    }
  },

}
