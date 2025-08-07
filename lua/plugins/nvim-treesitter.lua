return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  config = function ()
    require("nvim-treesitter").setup {
    }
    require'nvim-treesitter'.install { 'rust', 'cpp', 'c', 'lua' }
  end
}
