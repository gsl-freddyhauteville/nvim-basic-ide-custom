local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim", commit = "14571611c06e757f4f5fe46b82657417645c74dc" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim", commit = "4b66054e75356ac0b909bbfee9c682e703f535c2" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs", commit = "5fe24419e7a7ec536d78d60be1515b018ab41b15" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim", commit = "30d23aa2e1ba204a74d5dfb99777e9acbe9dd2d6" }
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08" }
  use { "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" }
  use { "kyazdani42/nvim-tree.lua", commit = "fb8735e96cecf004fbefb086ce85371d003c5129" }
  use { "akinsho/bufferline.nvim", commit = "2e5d92efacf40d488c4647a9e3e5100357b184cf" }
  use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
  use { "nvim-lualine/lualine.nvim", commit = "a52f078026b27694d2290e34efa61a6e4a690621" }
  use { "akinsho/toggleterm.nvim", commit = "5e393e558f7c41d132542c8e9626aa824a1caa59" }
  use { "ahmedkhalf/project.nvim", commit = "090bb11ee7eb76ebb9d0be1c6060eac4f69a240f" }
  use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }
  use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" }
  use { "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" }
  use {"folke/which-key.nvim", commit = "66e69bad5151cfaefb3a1cf54906574a0d19749b"}

  -- Colorschemes
  use { "folke/tokyonight.nvim", commit = "3e79e043dfdc31b320d61432eae2eefc26478965" }
  use { "lunarvim/darkplus.nvim", commit = "aa1f0a582dc897259b9cb8bebad64110da4d4cc4" }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp", commit = "913eb8599816b0b71fe959693080917d8063b26a" } -- The completion plugin
  use { "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" } -- buffer completions
  use { "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" } -- path completions
  use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
  use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }

  -- snippets
  use { "L3MON4D3/LuaSnip", commit = "e687d78fc95a7c04b0762d29cf36c789a6d94eda" } --snippet engine
  use { "rafamadriz/friendly-snippets", commit = "22a99756492a340c161ab122b0ded90ab115a1b3" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig", commit = "12735ee94a3eca96c4ebb799a62a0a7aa4733107" } -- enable LSP
  use { "williamboman/nvim-lsp-installer", commit = "12e7c06ca0a674061e461027fb67c29b026e423a" } -- simple to use language server installer
  use { "jose-elias-alvarez/null-ls.nvim", commit = "e755b1c20396ebb0762985142dfc04690663201f" } -- for formatters and linters
  use { "RRethy/vim-illuminate", commit = "1c8132dc81078fc1ec7a4a1492352b8f541ee84b" }

  -- Telescope
  use { "nvim-telescope/telescope.nvim", commit = "2584ff391b528d01bf5e8c04206d5902a79ebdde" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", commit = "518e27589c0463af15463c9d675c65e464efc2fe" }

  -- Git
  use { "lewis6991/gitsigns.nvim", commit = "c8b3d7968921b64532fa778f869509621d762f21" }

  -- DAP
  use { "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" }
  use { "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" }
  use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
