return {
  {
    'nvim-java/nvim-java',
    config = false,
    dependencies = {
      {
        'neovim/nvim-lspconfig',
        opts = {
          servers = {
            -- Your JDTLS configuration goes here
            jdtls = {
              -- settings = {
              --   java = {
              --     configuration = {
              --       runtimes = {
              --         {
              --           name = "JavaSE-23",
              --           path = "/usr/local/sdkman/candidates/java/23-tem",
              --         },
              --       },
              --     },
              --   },
              -- },
            },
          },
          setup = {
            jdtls = function()
              -- Your nvim-java configuration goes here
              require('java').setup({
                root_markers = {
                  'settings.gradle',
                  'settings.gradle.kts',
                  'pom.xml',
                  'build.gradle',
                  'mvnw',
                  'gradlew',
                  'build.gradle',
                  'build.gradle.kts',
                  '.git',
                },
                lombok = {
                  version = 'nightly',
                },
                spring_boot_tools = {
                  enable = true,
                },
                java_debug_adapter = {
                  enable = true,
                },
                java_test = {
                  enable = true,
                },
                jdk = {
                  auto_install = false,
                },
                notifications = {
                  dap = false,
                },
                verification = {
                  invalid_order = true,
                },
              })
            end,
          },
        },
      },
    },
  },
}
