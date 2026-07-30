return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      html = { 'prettier' },
      markdown = { 'mdformat', lsp_format = 'fallback' },
      nix = { 'nixpkgs-fmt', lsp_format = 'fallback' }
    },
  },
}
