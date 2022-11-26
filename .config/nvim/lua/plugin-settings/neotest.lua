local neotest = require("neotest")
neotest.setup({
  log_level = 1, -- For verbose logs
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require("neotest-dotnet"),
    require("neotest-rust"),
    require("neotest-jest"),
  },
})

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
  neotest.output.open({enter = true})
end, {})

cmd("NeotestSummaryOpen", function()
  neotest.summary.open()
end, {})

cmd("NeotestSummaryClose", function()
  neotest.summary.close()
end, {})

cmd("NeotestSummaryToggle", function()
  neotest.summary.toggle()
end, {})

cmd("NeotestOutputToggle", function()
  neotest.output_panel.toggle()
end, {})
