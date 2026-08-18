{
  inputs,
  self,
  ...
}: {
  perSystem = {
    pkgs,
    ...
  }: {
    packages.neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs;

      settings.config_directory = ./.;

      runtimePkgs = [
        pkgs.ffmpeg-full
        pkgs.wl-clipboard

        # LSPs
        pkgs.lua-language-server
        pkgs.typescript-language-server
        pkgs.astro-language-server
        pkgs.rust-analyzer
        pkgs.nixd
        pkgs.alejandra
        pkgs.gleam
        pkgs.mdx-language-server
      ];

      specs = {
        init = {
          data = null;
          before = ["MAIN_INIT"];
          config = "require('init')";
        };

        plugins = {
          data = [
            pkgs.vimPlugins.lz-n
            pkgs.vimPlugins.plenary-nvim
            pkgs.vimPlugins.nvim-lspconfig
            pkgs.vimPlugins.nvim-treesitter.withAllGrammars

            # completion
            pkgs.vimPlugins.nvim-web-devicons
            pkgs.vimPlugins.lspkind-nvim
            pkgs.vimPlugins.colorful-menu-nvim
            pkgs.vimPlugins.blink-cmp

            # misc
            pkgs.vimPlugins.snacks-nvim
            pkgs.vimPlugins.oil-nvim
            pkgs.vimPlugins.lualine-nvim
            pkgs.vimPlugins.luasnip
          ];
        };

        lazyPlugins = {
          lazy = true;
          data = [
            pkgs.vimPlugins.lazydev-nvim
            pkgs.vimPlugins.gitsigns-nvim
            pkgs.vimPlugins.nvim-autopairs
            pkgs.vimPlugins.fastaction-nvim
            pkgs.vimPlugins.mini-files
            pkgs.vimPlugins.codecompanion-nvim
          ];
        };

        # LSP configs
        lua-ls = {
          data = [pkgs.vimPlugins.nvim-lspconfig pkgs.vimPlugins.blink-cmp];
          config = ''vim.lsp.enable("lua_ls")'';
        };

        ts-ls = {
          data = [pkgs.vimPlugins.nvim-lspconfig];
          config = ''
            vim.lsp.config("ts_ls", {
              settings = {
                suggestionActions = {
                  enabled = false
                }
              }
            })
            vim.lsp.enable("ts_ls")
          '';
        };

        astro = {
          data = [pkgs.vimPlugins.nvim-lspconfig];
          config = ''
            vim.lsp.config("astro", {
              init_options = {
                typescript = {
                  tsdk = "node_modules/typescript/lib",
                }
              },
            })
            vim.lsp.enable("astro")
          '';
        };

        rust = {
          data = [pkgs.vimPlugins.nvim-lspconfig];
          config = ''vim.lsp.enable("rust_analyzer")'';
        };

        nix-ls = {
          data = [pkgs.vimPlugins.nvim-lspconfig];
          config = ''
            vim.lsp.config("nixd", {
              cmd = { "nixd" },
              settings = {
                nixd = {
                  nixpkgs = {
                    expr = "import <nixpkgs> { }",
                  },
                  formatting = {
                    command = { "alejandra" },
                  },
                },
              },
            })
            vim.lsp.enable("nixd")
          '';
        };

        mdx = {
          data = [pkgs.vimPlugins.nvim-lspconfig];
          config = ''
            vim.filetype.add({
              extension = {
                mdx = "mdx",
              },
            })
            vim.lsp.enable("mdx_analyzer")
          '';
        };

        gleam-ls = {
          data = [pkgs.vimPlugins.nvim-lspconfig];
          config = ''vim.lsp.enable("gleam")'';
        };
      };

      env.LADSPA_PATH = "${pkgs.deepfilternet}/lib/ladspa/libdeep_filter_ladspa.so";
    };
  };
}
