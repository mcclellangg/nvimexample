# Overview 

These instructions were heavily influenced by [TJ DeVries - Adevent of Neovim](https://www.youtube.com/playlist?list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM) series on YouTube. If you are interested in Neovim want to learn more about it (in depth) I suggest you start by creating your own config, and watching along with his series.

TJ is an excellent teacher and does a great job at breaking down the most important parts of Neovim and to get you started.

Creating these instructions helped cement my learnings from the series. This config serves as a solid starting point as I experiment with Neovim.

# Instructions

Instructions assume you will be installing on Linux (or Unix). I suspect you could follow along with these instructions on Windows if you swap occurrences of `~/.config/nvimexample` for `~/AppData/Local/nvimexample`.

See step 8 (Load user config) of [initialization](https://neovim.io/doc/user/starting/#initialization) in the Neovim docs.

I have not yet tried it on Windows myself.
## Install Neovim and create NVIM_APPNAME

1. Follow Neovim's [Quick Start](https://github.com/neovim/neovim/blob/master/BUILD.md#quick-start) instructions to build Neovim from source
    1. https://github.com/neovim/neovim/blob/master/BUILD.md
2. Create a new isolated config via `NVIM_APPNAME`
    1. `cd ~/.config`
    2. `mkdir nvimexample`
    3. `cd nvimexample`
3. Create an alias for your new `NVIM_APPNAME`  (I use [fish - command shell](https://fishshell.com/))
    1. `alias -s nvex="NVIM_APPNAME=nvimexample nvim"` 

 ❗ Additional instructions assume you will be opening Neovim with your new appname via one of these methods:

 4. `nvex` - alias
 5. `NVIM_APPNAME=nvimexample nvim` - manual execution
 
If you have never used Neovim before, the [tutor tutorial](https://neovim.io/doc/user/nvim/) is an excellent plate to start.
Open Neovim and run `:Tutor`.

**References**
- `:h NVIM_APPNAME` - execute in nvim for more details
- [TJ DeVries - Advent of Neovim: Why Neovim?](https://www.youtube.com/watch?v=TQn2hJeHQbM&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM&index=1)
- [neovim - nvim intro](https://neovim.io/doc/user/nvim/)
- [Github - neovim quickstart](https://github.com/neovim/neovim/blob/master/BUILD.md#quick-start)
- https://fishshell.com/
## Create init.lua (aka vimrc)

1. Create and open a new `init.lua` with Neovim
    1. Manually
        1.  `NVIM_APPNAME=nvimexample nvim init.lua`
    2. **OR** via your new alias
        1. `nvex init.lua`
2. Add the following code block `init.lua`
    1. Source [gist - Starter config](https://gist.github.com/mcclellangg/524cff56e6495a2f8542178277b402ef)

```lua
-- ═══════════════════════════════════════════════════════════════
-- STARTER CONFIG
-- Install and enable plugins/language_servers: 
-- 1. lazy
-- 2. lua_ls (and maybe oil)
-- ═══════════════════════════════════════════════════════════════

-- require("config.lazy")

local uv = vim.uv
print("Using: " .. uv.os_getenv("NVIM_APPNAME"))

-- ==== GREAT Advent of Neovim ====
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<space>nh", "<cmd>noh<CR>")

-- Basic
vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.api.nvim_set_hl(0, "Comment", { fg = "#FF2A54", italic = true })
vim.opt.scrolloff = 10


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank({higroup='DiffText', timeout=300})
  end,
})

-- ==== Terminal
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Custom terminal setup',
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.relativenumber = false
    vim.opt.linebreak = false
  end,
})

vim.keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)
end)

-- Dir Tree
vim.keymap.set("n", "<space>dt", function()
  vim.cmd.vnew()
  vim.cmd.wincmd("H") --move to far left
  vim.api.nvim_win_set_width(0, 30)
  -- vim.cmd("Oil")
end)

-- Enable lsps
-- vim.lsp.enable("lua_ls")

```

3. Save changes and restart Neovim
    1. `:wq` - write and quit
    2. `nvex init.lua` - run from terminal

### What this does
 
 Experimenting with command settings, and mappings by 'running commands' manually is fine. However running the same 60+ lines of commands just to start Neovim with your desired UI, keymaps, and option settings is tiresome.

`init.lua` (also known as `vimrc`) is the file we use to start Neovim with all our favorite settings. 'rc' is short for 'run commands', hence the name `vimrc`.

Here is what this `init.lua` provides.

`vim.opt.clipboard = "unnamedplus"` will set nvim to use the system keyboard instead of it's default registers for the clipboard. 

**Keymaps**
`<space><space>x` - execute the entire file (normal mode)
`<space>x` - execute the current line (normal mode)
`<space>x` - execute highlighted code (visual mode)

These keymaps are helpful for testing `vim.opt` changes in real time.

Adds UI changes, and an auto command that telegraphs which lines you 'yank' (or copy) by applying a highlight.

I also have some personal keymaps for Oil, terminal, and turning off search highlights.

The Neovim help IS FANTASTIC, be sure to exploit it constantly.

For details execute these commands from within Neovim:
`:h option-list` - provides a brief list of all options
`:h options` - an overview of options

Jump to [23 min mark](https://youtu.be/CuWfgiwI73Q?si=YB5ojO2_JGi6aKna&t=1415) of TJ's video to see a similar `init.lua` in action.

**References**
- [TJ DeVries - Everything You Need To Start Writing Lua](https://www.youtube.com/watch?v=CuWfgiwI73Q&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM&index=3)

## Configure per-language options (for Lua)

1. Navigate to your root config dir (if not there already)
    1. `cd ~/.config/nvimexample`
2. Create a directory for the filetype (ft) plugin 
    1. `mkdir after`
    2. `mkdir after/ftplugin`
3. Create and open the file with Neovim
    1. `nvex after/ftplugin/lua.lua`
4. Add the following code block to the file:

```lua
local set = vim.opt_local

set.shiftwidth = 2
set.number = true
set.relativenumber = true
```

### What this does

Filetype plugins can be used to set configurations for any other filetypes (or language) you use (Python, TypeScript, C, HTML, CSS). 

You can test out these changes in real time by:
1. Adding configurations to the ftplugin file (along with an example code block)
2. Re-edit the current file via `:e` 

It's notable that by by placing `ftplugins` in `/after` you can override the global default settings. This is because `after/ftplugins` are loaded AFTER global defaults. 


**References**
- More details from TJ: [YouTube - Configure Neovim Options](https://www.youtube.com/watch?v=F1CQVXA5gf0&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM&index=6)
- [neovim - ftplugin overrule](https://neovim.io/doc/user/filetype/#ftplugin-overrule)
- [neovim - ftplugin](https://neovim.io/doc/user/filetype/#_2.-filetype-plugin)

## Install a plugin manager (lazy.nvim)

Neovim has it's own plugin manager `vim.pack`. According to them though [it's still experimental, but stable enough for daily use](https://neovim.io/doc/user/pack/#vim.pack).

I enjoy the modular approach that `lazy.nvim` offers so I'm sticking with that for now.

[lazy.nvim](https://lazy.folke.io/) the plugin manager (not to be confused with LazyVim the IDE configuration) expects the following directory structure:

```bash
~/.config/nvimexample
├── lua
│   ├── config
│   │   └── lazy.lua
│   └── plugins
│       ├── spec1.lua
│       ├── **
│       └── spec2.lua
└── init.lua
```

1. Create the expected directory structure
    1. `cd ~/.config/nvimexample`
    2. `mkdir lua`
    3. `mkdir lua/config lua/plugins`
2. Follow [structured setup](https://lazy.folke.io/installation) installation instructions for `lazy.nvim`
    1. Create a new config for lazy and open it with Neovim
        1. `nvex ~/.config/nvimexample/lua/config/lazy.lua`
        2. Add the following code to bootstrap lazy.nvim:
    
```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    -- ══════════════════════════
    -- ! This will result in an error until you add plugins !
    -- ══════════════════════════
     { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
```

 2. Import lazy via require in `init.lua` by adding the following line in `init.lua`
        1. `require("config.lazy")`
3. Restart Neovim and verify lazy installation using:
    1. `:checkhealth lazy`
        1. I usually ignore luarocks related warnings
4. The following error is expected until you add your first plugin:

```bash
Error in ~/.config/nvimexample/init.lua:
No specs found for module "plugins"
```

**References**
- [lazy.nvim](https://lazy.folke.io/)
- [lazy.nvim - installation](https://lazy.folke.io/installation)
- [TJ DeVries - lazy.nvim explained](https://www.youtube.com/watch?v=_kPg0VBRxJc&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM&index=4)

## Install your first plugin (mini.nvim)

1. Create new config file for the plugin
    1. `nvex ~/.config/nvimexample/lua/plugins/mini.lua`
    2. Add the following code to enable status line

```lua
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
```

2. Save changes and restart Neovim for `lazy.nvim` to install
3. The previous error `No specs found for module "plugins"` should be resolved since a plugin was added
### What this gives us

This provides us a concise status line, installs icons (needed by later plugins like [oil.nvim](https://github.com/stevearc/oil.nvim)), and enables the `miniwnter` color scheme.

`mini.nvim` contains [many modules](https://nvim-mini.org/mini.nvim/#modules), that can all be used independently. Have fun and experiment!

#### A note on color
❗ I later realized that this color scheme may not have enough variation out of the box, making it harder to distinguish text objects when writing code.

This might be improved by:
1. Altering the saturation using [mini.hues](https://nvim-mini.org/mini.nvim/doc/mini-hues.html)
2. Using a more vibrant color scheme like [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)

I need to experiment with this a bit more.

**References**
- https://nvim-mini.org/
- [MiniMax - config examples](https://nvim-mini.org/MiniMax/)
    - GREAT inspo for creating your own minimal config

## Install nvim-treesitter

Neovim has the tree-sitter engine built in, but it doesn't have the parsers and queries for text objects. The plugin [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) needs to be installed to manage those parsers and queries.

1. Create a new config file for the plugin (just like we did for `mini.nvim`)
    1. `nvex ~/.config/nvimexample/lua/plugins/treesitter.lua`
    2. Add the following code block
```lua
-- lua/plugins/treesitter.lua
return {
	enabled = true,
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',
	config = function ()
	  require('nvim-treesitter').install({'rust', 'lua', 'vim', 'python', 'markdown', 'fish' , 'c'})
	end
}
```

3. Save changes and restart Neovim for `lazy.nvim` to install
4. Verify plugin install and installed languages
    1. `:checkhealth nvim-treesitter`
    2. 
5. Double check that the [requirements](https://github.com/nvim-treesitter/nvim-treesitter#requirements) are installed
    1. You may likely need to install [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md)
### What does this do

I am still experimenting to figure out how treesitter will fit in my own Neovim workflow. I suspect it could be used to apply `highlight-groups` to hyper specific situations. I haven't spent a ton of time messing around with it, but I get the sense that it could do some powerful things.

I recommend watching TJ's video (from his advent of neovim series): [Treesitter Basics and Installation](https://www.youtube.com/watch?v=MpnjYb-t12A&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM&index=6) to learn more. He is a fantastic teacher.

### Experimenting with nvim-treesitter

**Commands**
`:Inspect` - show items at cursor position in buffer
`:InspectTree` - displays nodes for a given language (if parsers installed)
Press `o` while in "inspect tree" mode to open an interactive query editor

Jump to the [10 minute mark](https://youtu.be/MpnjYb-t12A?si=V2oGjjuMKm38ZRMB&t=610) of TJ's video (same as above) to see these in action.

**References**
- https://github.com/nvim-treesitter/nvim-treesitter
- https://neovim.io/doc/user/treesitter/
- [TJ DeVries - Treesitter Basics and Installaion](https://youtu.be/MpnjYb-t12A?si=O6hgO0PMiaKucF_J)

## Install mason and enable lua_ls

1. Create a new config file for [mason.nvim](https://github.com/mason-org/mason.nvim) (repeat steps used for previous plugins mini and treesitter)
    1. `nvex ~/.config/nvimexample/lua/plugins/mason.lua`
    2. Add the following code block

```lua
-- lua/plugins/mason.lua
return {
  enabled = true,
  "mason-org/mason.nvim",
  opts = {}
}

```

2. Restart Neovim to install mason
3. Verify install
    1. `:checkhealth mason`
4. Use mason to add lua-language-server
    1. `:MasonInstall lua-language-server`
5. Create a new config to install [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) plugin and setup with [folke's lazydev.nvim](https://github.com/folke/lazydev.nvim)
    1. `nvex ~/.config/nvimexample/lua/plugins/lsp.lua`
    2. Add the following code block
    
```lua
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

```

3. Restart Neovim and verify install
    `:h lspconfig-all` - shows LSP configurations
4. Enable lua-language-server by adding this to your `init.lua`
    1. `vim.lsp.enable("lua_ls")`
5. Verify language server is attached
    1. `:checkhealth vim.lsp`
    2. You should now see it as an active client and what features you have enabled
        1. A buffer with a `.lua` file should be open to activate the LSP client 
### What does this do

The `nvim-lspconfig` (`lua/plugins/lsp.lua`) I shared is a bit of a bastard child, and perhaps not "optimal".  This code block installs the `nvim-lspconfig` and also uses [folke's lazydev.nvim](https://github.com/folke/lazydev.nvim) to configure the Lua language server for you. 

It sets up the `lua_language_server` so that you can start hacking around with your Neovim config sooner, but I suspect it would be problematic if you want to start configuring languages other than Lua.

Perhaps a better solution might be:
1. Install Mason (to handle language server installs only, or even just manually install [luals](https://luals.github.io/))
2. Install the `nvim-lspconfig` plugin
3. Configure each language as per the `nvim-lsp-config` instructions
    1. `:h nvim-lspconfig-all`

LSP facilitates POWERFUL features: diagnostics, autocompletion and definitions. Read the help to learn more `:h lsp`! The help is great, use the help! 

**Features enabled**
`ctrl + x ctrl + o` - omnicompletion 
`ctrl + ]` - go to tag/definition
`ctrl + t` - go back
`grr` - go to references
`grn` - rename
`K` - vim.lsp.buf.hover() GREAT info
`ctrl + w D` - open diagnostic buffer

**References**
- [mason.nvim](https://github.com/mason-org/mason.nvim)
- https://luals.github.io/
- https://github.com/neovim/nvim-lspconfig
- [TJ DeVries - LSP in Neovim](https://www.youtube.com/watch?v=bTWWFQZqzyI&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM&index=7)
- [TJ DeVries - LSP Explained](https://www.youtube.com/watch?v=LaS32vctfOY&t=1s)

## Install oil and telescope

Hopefully by now you have gathered how the plugin installation process works.
1. Create a new file under `/lua/plugins`
2. Add the default code for the plugin from the site
3. Restart Neovim for lazy to install it, and  run `:checkhealth` to screen for any issues

Install [oil.nvim](https://github.com/stevearc/oil.nvim)

```lua
-- lua/plugins/oil.lua
return {
  enabled = true,
  "stevearc/oil.nvim",
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  lazy = false,
  opts = {
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
  },
}
```

Install [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

```lua
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


  -- Handy keymaps for common nvim searches
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
```

### What this gives us

The oil about says it all:

> Neovim file explorer: edit your filesystem like a buffer

Telescope is a fuzzy file finder, originally created by [TJ DeVries](https://github.com/tjdevries). Check out his videos from the [advent-of-neovim](https://www.youtube.com/playlist?list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM) series to learn more about both of these plugins!

**References**
-  [TJ DeVries - OIL NVIM IS SO GOOD](https://www.youtube.com/watch?v=-r1mMg-yVZE&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM&index=14)
-  [TJ DeVries - telescope.nvim introduction](https://www.youtube.com/watch?v=iqdCshrIKIg&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM&index=9)
- https://github.com/stevearc/oil.nvim
- https://github.com/nvim-telescope/telescope.nvim

# Conclusion

This should be a config that makes it easier to edit your own config and mess with Neovim. Experimenting is the best way to learn.

What's next:
- Watch TJ's videos they are incredible!

Have fun with Neovim and get it to work the way YOU want it to! I hope you found this guide helpful and enjoyable!

Remember [you can just do things](https://www.youtube.com/watch?v=X7HFU786NiQ&list=PLep05UYkc6wTyBe7kPjQFWVXTlhKeQejM&index=26)! 
# Outstanding questions

- Why should I continue to use lazy.nvim plugin manager over `vim.pack`?
- Why would I need both `.editorconfig` and `after/ftplugin`?
    - Having formatting in both seems redundant. I suspect the benefit of setting options in `after` is that it will override defaults (is that the only one)?
    - `.editorconfig` (as per TJ) respects both Neovim and LSP
- Best way to autoformat for any language server I have on save?

