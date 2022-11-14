require("ultest").setup({
  builders = {
    ['python#pytest'] = function(cmd)
      local non_modules = { 'python' }
      -- Index of the python module to run the test.
      local module_index = 1
      if vim.tbl_contains(non_modules, cmd[1]) then
        module_index = 3
      end
      local module = cmd[module_index]

      -- Remaining elements are arguments to the module
      local args = vim.list_slice(cmd, module_index + 1)
      return {
        dap = {
          type = 'python',
          request = 'launch',
          module = module,
          args = args,
          justMyCode = false
        }
      }
    end,
    ['rust#cargotest'] = function()
      return {
        dap = {
          type = 'lldb',
          request = 'launch',
        }
      }
    end
  }
})
vim.cmd([[
let test#csharp#runner = 'dotnettest'
let test#python#pytest#options = "--color=yes"
let test#javascript#jest#options = "--color=always"
]])
vim.cmd("let g:ultest_deprecation_notice = 0")
