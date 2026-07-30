return {
  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
      { 'kyza0d/vocal.nvim' }, -- Añadimos vocal como dependencia
    },
    config = function()
      local opencode = require('opencode')
      local vocal = require('vocal')

      -- 1. Configuración de Vocal para usar tu whisper-cli optimizado
      -- instalar antes las dependencias con sudo pacman -S sox python-openai-whisper
      vocal.setup({
        local_model = {
          model = 'base', -- Model size: tiny, base, small, medium, large
          path = '~/whisper', -- Path to download and store models
        },
        -- Comando de transcripción usando tu binario y modelo base
        -- transcription_command = string.format(
        --   'whisper-cli -m %s/.local/share/whisper-models/ggml-base.bin -l es -nt -np -t %s',
        --   os.getenv('HOME'),
        --   io.popen('nproc'):read('*all'):gsub('%s+', '')
        -- ),
        -- -- Tu comando de grabación que ya sabemos que funciona en Arch
        -- record_command = 'rec -r 16000 -c 1 -b 16 %s silence 1 0.1 3% 1 2.0 3%',
      })

      -- AIDEV-NOTE: Función puente entre Vocal y OpenCode para transcripción de voz
      local function voice_to_opencode_vocal()
        vocal.transcribe({
          callback = function(text)
            if text and #text > 2 then
              opencode.open_chat()
              -- AIDEV-NOTE: Delay aumentado a 250ms para asegurar que el chat esté listo
              vim.defer_fn(function()
                opencode.send_message(text)
              end, 250)
            else
              vim.notify('No se detectó texto', vim.log.levels.WARN)
            end
          end,
        })
      end

      -- === CONFIGURACIÓN Y KEYMAPS DE OPENCODE ===
      vim.opt.autoread = true
      vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
        require('opencode').ask('@this: ', { submit = true })
      end, { desc = 'Ask about this' })
      vim.keymap.set({ 'n', 'x' }, '<leader>o+', function()
        require('opencode').prompt('@this')
      end, { desc = 'Add this' })
      vim.keymap.set({ 'n', 'x' }, '<leader>op', function()
        require('opencode').select()
      end, { desc = 'Select prompt' })
      vim.keymap.set('n', '<leader>ot', function()
        require('opencode').toggle()
      end, { desc = 'Toggle embedded' })
      vim.keymap.set('n', '<leader>oe', function()
        require('opencode').prompt('Explain @cursor and its context')
      end, { desc = 'Explain code near cursor' })
      vim.keymap.set('n', '<leader>oc', function()
        require('opencode').command()
      end, { desc = 'Select command' })
      vim.keymap.set('n', '<leader>on', function()
        require('opencode').command('session_new')
      end, { desc = 'New session' })
      vim.keymap.set('n', '<leader>oi', function()
        require('opencode').command('session_interrupt')
      end, { desc = 'Interrupt session' })
      vim.keymap.set('n', '<leader>oA', function()
        require('opencode').command('agent_cycle')
      end, { desc = 'Cycle selected agent' })
      vim.keymap.set('n', '<S-C-u>', function()
        require('opencode').command('messages_half_page_up')
      end, { desc = 'Messages half page up' })
      vim.keymap.set('n', '<S-C-d>', function()
        require('opencode').command('messages_half_page_down')
      end, { desc = 'Messages half page down' })
      -- AIDEV-NOTE: Incluye modo 't' (terminal) con <C-v> para usar vocal desde la ventana de opencode sin doble Esc
      vim.keymap.set('n', '<leader>v', voice_to_opencode_vocal, { desc = 'OpenCode Voice (Vocal.nvim)' })
      vim.keymap.set('t', '<C-v>', voice_to_opencode_vocal, { desc = 'OpenCode Voice (Vocal.nvim)' })
    end,
  },
}
