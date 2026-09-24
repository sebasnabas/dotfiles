-- Converts selected CSV lines into a markdown pipe table, the flavour
-- Confluence Cloud turns into a real table on paste. Exposes the conversion
-- as a pure function so it can be driven from tests/csv-to-markdown_spec.lua.

local M = {}

---Split one CSV line into its fields, honouring RFC 4180 quoting.
---
---A quoted field keeps any comma inside it, and a doubled quote inside a
---quoted field is read as one literal quote.
---
---@param line string A single line of CSV.
---@return string[] fields The values, with the quoting interpreted and removed.
local function split_fields(line)
  local fields = {}
  local value = {}
  local quoted = false
  local i = 1

  while i <= #line do
    local char = line:sub(i, i)

    -- Inside quotes only a quote is special, and a doubled one is an escape.
    if quoted then
      if char == '"' and line:sub(i + 1, i + 1) == '"' then
        table.insert(value, '"')
        i = i + 1
      elseif char == '"' then
        quoted = false
      else
        table.insert(value, char)
      end
    elseif char == '"' then
      quoted = true
    elseif char == "," then
      table.insert(fields, table.concat(value))
      value = {}
    else
      table.insert(value, char)
    end

    i = i + 1
  end

  table.insert(fields, table.concat(value))

  return fields
end

---Render a list of values as one markdown table row.
---
---@param fields string[] The values of a single row.
---@return string row The row, pipe delimited and padded with single spaces.
local function render_row(fields)
  local cells = {}

  -- A pipe inside a value would read as a column break, so it has to be escaped.
  for _, field in ipairs(fields) do
    table.insert(cells, (vim.trim(field):gsub("|", "\\|")))
  end

  return "| " .. table.concat(cells, " | ") .. " |"
end

---Convert CSV lines into the lines of a markdown pipe table.
---
---The first non-blank line becomes the header and is followed by a separator
---sized to its column count. Blank lines are dropped rather than rendered as
---empty rows.
---
---@param lines string[] The CSV lines to convert.
---@return string[] markdown The table lines, empty when there is nothing to convert.
function M.convert(lines)
  local rows = {}

  for _, line in ipairs(lines) do
    if vim.trim(line) ~= "" then
      table.insert(rows, split_fields(line))
    end
  end

  if #rows == 0 then
    return {}
  end

  -- The header decides the width, so a short or long body row cannot resize it.
  local separator = {}

  for _ = 1, #rows[1] do
    table.insert(separator, "---")
  end

  local markdown = { render_row(rows[1]), render_row(separator) }

  for i = 2, #rows do
    table.insert(markdown, render_row(rows[i]))
  end

  return markdown
end

vim.api.nvim_create_user_command("CsvToMarkdown", function(opts)
  -- With no range the selection is just wherever the cursor sits, which is
  -- never what was meant, so say so instead of converting a single line.
  if opts.range == 0 then
    vim.notify("CsvToMarkdown: select the CSV lines first", vim.log.levels.WARN)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  local markdown = M.convert(lines)

  -- Replacing with nothing would delete the range, so an empty result is a no-op.
  if #markdown == 0 then
    vim.notify("CsvToMarkdown: no CSV rows in range", vim.log.levels.WARN)
    return
  end

  vim.api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line2, false, markdown)
end, { range = true, desc = "Rewrite the selected CSV lines as a markdown table" })

return M
