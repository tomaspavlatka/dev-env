return {
  'nvim-java/nvim-java',
  config = function()
    require('java').setup()
    require('lspconfig').jdtls.setup({
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "Java 17",
                path = "/usr/bin/java",
                default = true
              }
            }
          }
        }
      },
      cmd = {
        'jdtls',
        '--jvm-arg=-javaagent:/home/tomaspavlatka/.config/nvim/lombok.jar',
        '-Xms1g',
        '-Xmx2G',
        '-XX:+UseG1GC',
        '-XX:+UseStringDeduplication'
      },
      root_dir = vim.fn.getcwd(),
      import = {
        gradle = { enabled = true },
        maren = { enabled = false }
      }
    })
  end
}
