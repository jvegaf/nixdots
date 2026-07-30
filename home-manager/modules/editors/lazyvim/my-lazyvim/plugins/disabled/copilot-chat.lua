-- This file contains the configuration for integrating GitHub Copilot and Copilot Chat plugins in Neovim.

-- Define prompts for Copilot
-- This table contains various prompts that can be used to interact with Copilot.
local prompts = {
  Explain = 'Please explain how the following code works.', -- Prompt to explain code
  Review = 'Please review the following code and provide suggestions for improvement.', -- Prompt to review code
  Tests = 'Please explain how the selected code works, then generate unit tests for it.', -- Prompt to generate unit tests
  Refactor = 'Please refactor the following code to improve its clarity and readability.', -- Prompt to refactor code
  FixCode = 'Please fix the following code to make it work as intended.', -- Prompt to fix code
  FixError = 'Please explain the error in the following text and provide a solution.', -- Prompt to fix errors
  BetterNamings = 'Please provide better names for the following variables and functions.', -- Prompt to suggest better names
  Documentation = 'Please provide documentation for the following code.', -- Prompt to generate documentation
  JsDocs = 'Please provide JsDocs for the following code.', -- Prompt to generate JsDocs
  DocumentationForGithub = 'Please provide documentation for the following code ready for GitHub using markdown.', -- Prompt to generate GitHub documentation
  CreateAPost = 'Please provide documentation for the following code to post it in social media, like Linkedin, it has be deep, well explained and easy to understand. Also do it in a fun and engaging way.', -- Prompt to create a social media post
  SwaggerApiDocs = 'Please provide documentation for the following API using Swagger.', -- Prompt to generate Swagger API docs
  SwaggerJsDocs = 'Please write JSDoc for the following API using Swagger.', -- Prompt to generate Swagger JsDocs
  Summarize = 'Please summarize the following text.', -- Prompt to summarize text
  Spelling = 'Please correct any grammar and spelling errors in the following text.', -- Prompt to correct spelling and grammar
  Wording = 'Please improve the grammar and wording of the following text.', -- Prompt to improve wording
  Concise = 'Please rewrite the following text to make it more concise.', -- Prompt to make text concise
  Commit = 'Please generate a commit message with stagging changes',
}

return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken', -- MacOS/Linux only
    opts = {
      show_help = 'no',
      prompts = prompts,
      model = 'gpt-5-mini', -- GPT model to use, see ':CopilotChatModels' for available models

      window = {
        layout = 'vertical', -- 'float' | 'vertical' | 'horizontal'
        position = 'right', -- only for vertical
        width = 0.4, -- 40% of editor width
      },
    },
    keys = {
      { '<Leader>ac', ':CopilotChat<CR>', mode = 'n', desc = 'Chat with Copilot' },
      { '<Leader>ae', ':CopilotChatExplain<CR>', mode = 'v', desc = 'Explain Code' },
      { '<Leader>ar', ':CopilotChatReview<CR>', mode = 'v', desc = 'Review Code' },
      { '<Leader>af', ':CopilotChatFix<CR>', mode = 'v', desc = 'Fix Code Issues' },
      { '<Leader>ao', ':CopilotChatOptimize<CR>', mode = 'v', desc = 'Optimize Code' },
      { '<Leader>ad', ':CopilotChatDocs<CR>', mode = 'v', desc = 'Generate Docs' },
      { '<Leader>at', ':CopilotChatTests<CR>', mode = 'v', desc = 'Generate Tests' },
      { '<Leader>am', ':CopilotChatCommit<CR>', mode = 'n', desc = 'Commit Message' },
      { '<Leader>as', ':CopilotChatCommit<CR>', mode = 'v', desc = 'Commit for Selection' },
    },
  },
  {
    'saghen/blink.cmp',
    optional = true,
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        providers = {
          path = {
            -- Path sources triggered by "/" interfere with CopilotChat commands
            enabled = function()
              return vim.bo.filetype ~= 'copilot-chat'
            end,
          },
        },
      },
    },
  },
}
