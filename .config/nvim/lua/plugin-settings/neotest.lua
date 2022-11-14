local neotest = require("neotest")
neotest.setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim" },
    }),
  },
})

vim.cmd("let g:test#csharp#runner='dotnettest'")

local cmd = vim.api.nvim_create_user_command

cmd("NeoTestFile", function()
  neotest.run.run(vim.fn.expand("%"))
end, {})

cmd("NeoTestNearest", function()
  neotest.run.run()
end, {})

cmd("NeoTestDebugNearest", function()
  neotest.run.run({strategy = "dap"})
end, {})

cmd("NeoTestStopNearest", function()
  neotest.run.stop()
end, {})

cmd("NeoTestAttachToNearest", function()
  neotest.run.attach()
end, {})

cmd("NeoTestOutput", function()
  vim.cmd('neotest.output')
end, {})

