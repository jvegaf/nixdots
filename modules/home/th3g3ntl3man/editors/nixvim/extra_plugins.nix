{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    url-open
    urlview-nvim
  ];

  extraConfigLua = ''
    require('url-open').setup({
      open_app = 'default',
      open_only_when_cursor_on_url = false,
      highlight_url = {
        all_urls = {
          enabled = true,
          fg = '#199eff',
          underline = true,
        },
        cursor_move = {
          enabled = true,
          fg = '#21d5ff',
          underline = true,
        },
      },
    })

    require('urlview').setup({
      default_action = 'system',
      default_picker = 'native',
      jump = {
        prev = '[u',
        next = ']u',
      },
    })
  '';
}
