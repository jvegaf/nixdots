{
  lib,
  pkgs,
  ...
}:
{
  keymaps = [
    {
      mode = "n";
      key = "<leader>ul";
      action.__raw = ''
        function()
          vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines, virtual_text = vim.diagnostic.config().virtual_lines })
        end
      '';
      options.desc = "Toggle lsp virtual lines";
    }
    {
      mode = "n";
      key = "<leader>uL";
      action.__raw = ''
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end
      '';
      options.desc = "Toggle lsp inlay hints";
    }
  ];

  lsp = {
    servers = {
      bashls.enable = true;
      basedpyright.enable = true;
      clangd.enable = true;
      cssls.enable = true;
      # gopls.enable = true;
      jdtls.enable = true;
      html.enable = true;
      jsonls.enable = true;
      just.enable = true;
      lemminx.enable = true;
      lua_ls.enable = true;
      nil_ls.enable = true;
      nixd = {
        enable = true;
      };
      marksman.enable = false;
      markdown_oxide.enable = false;
      pylsp.enable = true;
      ruff.enable = true;
      statix.enable = true;
      taplo.enable = true;
      texlab.enable = false;
      yamlls.enable = true;
      # zls.enable = true;  # XXX: broken
    };
    keymaps = [
      {
        key = "gd";
        lspBufAction = "definition";
      }
      {
        key = "gt";
        lspBufAction = "type_definition";
      }
      {
        key = "gi";
        lspBufAction = "implementation";
      }
      {
        key = "K";
        lspBufAction = "hover";
      }
      {
        key = "<leader>k";
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
      }
      {
        key = "<leader>j";
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
      }
      {
        key = "<leader>lx";
        action = "<CMD>LspStop<Enter>";
      }
      {
        key = "<leader>ls";
        action = "<CMD>LspStart<Enter>";
      }
      {
        key = "<leader>lr";
        action = "<CMD>LspRestart<Enter>";
      }
      {
        key = "rn";
        lspBufAction = "rename";
      }
      {
        key = "ca";
        lspBufAction = "code_action";
      }
    ];
  };

  plugins = {
    lsp.enable = true;
    rustaceanvim = {
      enable = false;
      settings.server = {
        standalone = false;
      };
    };
    typescript-tools = {
      enable = true;
      settings.settings = {
        expose_as_code_action = "all";
      };
    };
    jdtls.enable = true;
    # otter.enable = true;
  };
}
