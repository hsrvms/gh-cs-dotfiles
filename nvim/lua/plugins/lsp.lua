return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "templ",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        templ = {},
      },
    },
  },
}
