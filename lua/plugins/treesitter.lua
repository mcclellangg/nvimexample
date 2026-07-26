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
