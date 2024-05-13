local neotest = require("neotest")
neotest.setup({
  log_level = 1, -- For verbose logs
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
    }),
    require("neotest-dotnet")({
      discovery_root = "solution"
    }),
    require("neotest-rust"),
    require("neotest-jest"),
  },
})

local cmd = vim.api.nvim_create_user_command

local function parse_env_vars(args)
  local env = {}
  for _, arg in pairs(args) do
    local parts = vim.split(arg, "'")
    local key = vim.split(parts[1], "=")[1]
    local value = table.concat(parts, "", 2)

    print(key .. " = " .. value)
    env[key] = value
  end
  return env
end

cmd("NeoTestFile", function()
  neotest.run.run(vim.fn.expand("%"))
end, {})

cmd("NeoTestDebugFile", function(opt)
  neotest.run.run({
    vim.fn.expand("%"),
    strategy = "dap"
  })
end, { nargs = "*" })

cmd("NeoTestNearest", function(opt)
  neotest.run.run({
      env = parse_env_vars(opt.fargs)
    })
end, { nargs = "*" })

cmd("NeoTestDebugNearest", function(opt)
  neotest.run.run({
    strategy = "dap",
    env = parse_env_vars(opt.fargs)
  })
end, { nargs = "*" })

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
