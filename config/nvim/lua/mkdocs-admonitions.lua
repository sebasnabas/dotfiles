-- Renders mkdocs-material admonitions (`!!! note "Title"`, `??? tip`,
-- `???+ warning`) in markdown buffers the way markview renders callouts.
-- Markview cannot parse them and tree-sitter-markdown splits them across a
-- paragraph and an indented code block, so this module finds them with a line
-- scan and draws them with extmarks of its own, in mkdocs-material's colours.
-- The design and its trade-offs are in
-- .requirements/20260925T095525Z_mkdocs_admonitions/REQUIREMENTS.md.

local M = {}

M.ns = vim.api.nvim_create_namespace("mkdocs_admonitions")

---@class mkdocs_admonitions.Block
---@field row integer 0-based row of the header.
---@field indent integer Indent of the header in columns, tabs counting to multiples of 4.
---@field indent_bytes integer Indent of the header in bytes.
---@field marker "!!!"|"???" The marker; `???` is a collapsible admonition.
---@field open boolean Whether a collapsible admonition starts open (`???+`).
---@field kind string The admonition type, lower-cased.
---@field title string The title to show, `""` for none.
---@field depth integer Number of admonitions enclosing this one.
---@field body_start integer 0-based first body row.
---@field body_end integer 0-based last body row, `body_start - 1` when the body is empty.

---Advance a column past one indentation character.
---
---@param cols integer The column before the character.
---@param ch string A space or a tab.
---@return integer cols The column after it, a tab advancing to the next multiple of 4.
local function advance(cols, ch)
  return ch == "\t" and (math.floor(cols / 4) + 1) * 4 or cols + 1
end

---Measure the indentation of a line the way Python-Markdown does.
---
---@param line string
---@return integer cols Indent in columns, a tab advancing to the next multiple of 4.
---@return integer bytes Indent in bytes.
local function indent_of(line)
  local ws = line:match("^[ \t]*")
  local cols = 0
  for ch in ws:gmatch(".") do
    cols = advance(cols, ch)
  end
  return cols, #ws
end

---Parse the text after the indent as an admonition header.
---
---@param text string The line with its indentation removed.
---@return table? header `{ marker, open, kind, title }`, nil when the text is no header.
local function parse_header(text)
  local marker, open, rest = "!!!", false, text:match("^!!!(.*)$")
  if not rest then
    local plus
    plus, rest = text:match("^%?%?%?(%+?)(.*)$")
    if not rest then
      return nil
    end
    marker, open = "???", plus == "+"
  end

  -- `???` may carry just a title, which pymdownx renders as an untyped details block.
  local title = marker == "???" and rest:match('^ +"(.*)"%s*$')
  if title then
    return { marker = marker, open = open, kind = "note", title = title }
  end
  rest = rest:gsub("^ ", "", 1)

  -- One or more classes, the first being the type, then an optional quoted title.
  local classes, tail = rest:match("^([%w_-]+[%w_ -]*)(.*)$")
  if not classes then
    return nil
  end
  if tail ~= "" then
    title = tail:match('^"(.*)"%s*$')
    if not title or not classes:match(" $") then
      return nil
    end
  end
  local kind = classes:match("^[%w_-]+"):lower()
  title = title or (kind:sub(1, 1):upper() .. kind:sub(2))
  return { marker = marker, open = open, kind = kind, title = title }
end

---Read the fence opened by a line, if any.
---
---@param line string
---@return table? fence `{ char, len }` of the opening fence.
local function fence_open(line)
  local run = line:match("^%s*(```+)") or line:match("^%s*(~~~+)")
  return run and { char = run:sub(1, 1), len = #run } or nil
end

---Tell whether a line closes the given fence.
---
---@param line string
---@param fence table The `{ char, len }` of the open fence.
---@return boolean
local function fence_closes(line, fence)
  local run = line:match("^%s*(" .. (fence.char == "`" and "`" or "~") .. "+)%s*$")
  return run ~= nil and #run >= fence.len
end

---Read the column where the content of a list item starts.
---
---@param line string
---@return integer? col The content column, nil when the line is no list item or is a thematic break.
local function list_content_col(line)
  if line:match("^%s*[-*_]%s*[-*_]%s*[-*_][-*_%s]*$") then
    return nil
  end
  local lead, marker, gap = line:match("^(%s*)([-*+])(%s+)%S")
  if not lead then
    lead, marker, gap = line:match("^(%s*)(%d+[.)])(%s+)%S")
  end
  if not lead then
    return nil
  end
  return indent_of(lead) + #marker + #gap
end

---Tell whether a deeply indented line is content of a list item.
---
---Walks back over the lines of the item's paragraphs to the item itself; a
---line at or below the container's own indent ends the walk without a match.
---@param seen string[] The non-blank lines before this one.
---@param cols integer Indent of the line in columns.
---@param content integer Content column of the enclosing container.
---@return boolean
local function under_list_item(seen, cols, content)
  for i = #seen, 1, -1 do
    local item = list_content_col(seen[i])
    if item then
      return cols >= item and cols - item < 4
    end
    if indent_of(seen[i]) <= content then
      return false
    end
  end
  return false
end

---Find every admonition in a list of lines.
---
---Headers inside fenced code blocks and front matter are skipped. A header
---indented four columns or more past its container only counts under a list
---item, since anywhere else Python-Markdown reads it as an indented code block.
---@param lines string[] The buffer lines.
---@return mkdocs_admonitions.Block[] blocks In header order, nested blocks after their parent.
function M.parse(lines)
  local blocks = {}
  -- Open admonitions, innermost last; the document itself is the bottom frame.
  local stack = { { content = 0 } }
  -- Non-blank rows seen so far, for finding the list item a line hangs under.
  local seen = {}

  -- Front matter is skipped only once it is closed; an open `---` is a rule.
  local first = 1
  if lines[1] == "---" then
    for row = 2, #lines do
      if lines[row] == "---" or lines[row] == "..." then
        first = row + 1
        break
      end
    end
  end

  for row = first, #lines do
    local line = lines[row]
    local blank = line:match("^%s*$") ~= nil
    local cols, bytes = indent_of(line)

    -- A non-blank line shallower than a body's content column ends that body.
    if not blank then
      while #stack > 1 and cols < stack[#stack].content do
        table.remove(stack)
      end
    end
    local frame = stack[#stack]

    -- Inside a fence nothing is a header until the fence closes.
    if frame.fence then
      if fence_closes(line, frame.fence) then
        frame.fence = nil
      end
    elseif not blank then
      -- Four columns past the container is indented code, unless a list item holds the line.
      local deep = cols - frame.content >= 4 and not under_list_item(seen, cols, frame.content)
      local header = not deep and parse_header(line:sub(bytes + 1)) or nil

      if header then
        header.row = row - 1
        header.indent = cols
        header.indent_bytes = bytes
        header.depth = #stack - 1
        header.body_start = row
        header.body_end = row - 1
        table.insert(blocks, header)
        table.insert(stack, { content = cols + 4, block = header })
      elseif not deep then
        frame.fence = fence_open(line)
      end
    end

    if not blank then
      -- Every open admonition holds this line, so each body extends to it.
      for i = 2, #stack do
        if stack[i].block.row ~= row - 1 then
          stack[i].block.body_end = row - 1
        end
      end
      table.insert(seen, line)
    end
  end

  return blocks
end

-- mkdocs-material's types, colours and Material Design icons, from its _admonition.scss.
local TYPES = {
  note = { color = 0x448aff, icon = "󰛿" },
  abstract = { color = 0x00b0ff, icon = "󰅍" },
  info = { color = 0x00b8d4, icon = "󰋼" },
  tip = { color = 0x00bfa5, icon = "󰈸" },
  success = { color = 0x00c853, icon = "󰄬" },
  question = { color = 0x64dd17, icon = "󰋗" },
  warning = { color = 0xff9100, icon = "󰀦" },
  failure = { color = 0xff5252, icon = "󰅖" },
  danger = { color = 0xff1744, icon = "󰠠" },
  bug = { color = 0xf50057, icon = "󱏚" },
  example = { color = 0x7c4dff, icon = "󰙨" },
  quote = { color = 0x9e9e9e, icon = "󰉾" },
}

-- Deprecated qualifiers mkdocs-material still accepts.
local ALIASES = {
  summary = "abstract", tldr = "abstract", todo = "info", hint = "tip", important = "tip",
  check = "success", done = "success", help = "question", faq = "question", caution = "warning",
  attention = "warning", fail = "failure", missing = "failure", error = "danger", cite = "quote",
}

---Name the highlight group of a type.
---
---@param kind string A key of `TYPES`.
---@return string group `MkdocsAdmonition<Type>`.
local function group_of(kind)
  return "MkdocsAdmonition" .. kind:sub(1, 1):upper() .. kind:sub(2)
end

---Look up how an admonition type is drawn.
---
---@param kind string The admonition type.
---@return table config `{ icon, hl, title_hl, border }`.
function M.config_for(kind)
  kind = ALIASES[kind] or kind
  if not TYPES[kind] then
    kind = "note"
  end
  local group = group_of(kind)
  return { icon = TYPES[kind].icon, hl = group, title_hl = group .. "Title", border = "▋" }
end

---Find the byte of a line's indentation that sits at a given column.
---
---@param line string
---@param col integer Column, tabs counting to multiples of 4.
---@return integer? byte 0-based byte, nil when the indentation ends before the column.
local function byte_at_col(line, col)
  local cols = 0
  for i = 1, #line do
    local ch = line:sub(i, i)
    if ch ~= " " and ch ~= "\t" then
      return nil
    end
    local next_cols = advance(cols, ch)
    -- A tab that spans the column stands in for it.
    if cols == col or next_cols > col then
      return i - 1
    end
    cols = next_cols
  end
  return nil
end

---Draw the header and border of one admonition.
---
---@param buf integer
---@param lines string[] The buffer lines.
---@param block mkdocs_admonitions.Block
local function draw_frame(buf, lines, block)
  local config = M.config_for(block.kind)
  local header = lines[block.row + 1]

  -- The header text gives way to chevron, icon and title.
  local label = config.icon
  if block.title ~= "" then
    label = label .. " " .. block.title
  end
  if block.marker == "???" then
    label = (block.open and "▾ " or "▸ ") .. label
  end
  vim.api.nvim_buf_set_extmark(buf, M.ns, block.row, block.indent_bytes, {
    end_col = #header,
    conceal = "",
    virt_text = { { label, config.title_hl } },
    virt_text_pos = "inline",
    line_hl_group = config.title_hl,
    undo_restore = false,
    invalidate = true,
  })

  -- The border overlays the indent so text does not move; short rows place it by window column.
  for row = block.body_start, block.body_end do
    local byte = byte_at_col(lines[row + 1], block.indent)
    local opts = { virt_text = { { config.border, config.hl } }, undo_restore = false, invalidate = true }
    if byte then
      opts.virt_text_pos = "overlay"
    else
      byte, opts.virt_text_win_col = 0, block.indent
    end
    vim.api.nvim_buf_set_extmark(buf, M.ns, row, byte, opts)
  end
end

---Remove a body's indentation, the way Python-Markdown does before parsing it.
---
---@param lines string[] The buffer lines.
---@param block mkdocs_admonitions.Block
---@return string text The dedented body joined by newlines.
---@return integer[] offsets Bytes removed from each body row, indexed from 0.
local function dedent(lines, block)
  local content = block.indent + 4
  local out, offsets = {}, {}
  for row = block.body_start, block.body_end do
    local line = lines[row + 1]
    local cols, off = 0, 0
    while off < #line and cols < content do
      local ch = line:sub(off + 1, off + 1)
      if ch ~= " " and ch ~= "\t" then
        break
      end
      cols = advance(cols, ch)
      off = off + 1
    end
    offsets[row - block.body_start] = off
    table.insert(out, line:sub(off + 1))
  end
  return table.concat(out, "\n"), offsets
end

-- Captures per dedented body text, positions relative to that text.
local cache = {}
local cache_size = 0

---Read a capture's metadata value, set either on the match or on the capture.
---
---@param metadata table The metadata `iter_captures` returns.
---@param id integer The capture id.
---@param key string
---@return any
local function meta(metadata, id, key)
  return metadata[key] or (metadata[id] and metadata[id][key])
end

---Collect the highlight captures of a markdown text and its injections.
---
---Only highlight groups and inline conceal are kept: conceal from the block
---level markdown tree would hide code fence rows that markview does not
---redraw inside an admonition.
---@param text string
---@return table[] captures `{ sr, sc, er, ec, hl?, conceal?, offset }` items.
local function captures_of(text)
  if cache[text] then
    return cache[text]
  end

  local captures = {}
  local ok, parser = pcall(vim.treesitter.get_string_parser, text, "markdown")
  if ok and pcall(parser.parse, parser, true) then
    parser:for_each_tree(function(tree, ltree)
      local lang = ltree:lang()
      local qok, query = pcall(vim.treesitter.query.get, lang, "highlights")
      if not qok or not query then
        return
      end
      for id, node, metadata in query:iter_captures(tree:root(), text) do
        local name = query.captures[id]
        local conceal = lang ~= "markdown" and meta(metadata, id, "conceal") or nil
        local hl
        if not (name:match("^_") or name == "spell" or name == "nospell" or name == "conceal") then
          hl = "@" .. name .. "." .. lang
        end
        if hl or conceal then
          local priority = tonumber(meta(metadata, id, "priority")) or 100
          local sr, sc, er, ec = node:range()
          table.insert(captures, {
            sr = sr, sc = sc, er = er, ec = ec, hl = hl, conceal = conceal,
            offset = math.min(math.max(priority - 100, 0), 18),
          })
        end
      end
    end)
  end

  -- Bodies are few per buffer; dropping everything now and then bounds the cache.
  if cache_size > 500 then
    cache, cache_size = {}, 0
  end
  cache[text] = captures
  cache_size = cache_size + 1
  return captures
end

---Highlight an admonition body as ordinary markdown.
---
---The body is parsed on its own with its indentation removed and every
---capture is copied back shifted by that indentation, over a base highlight
---that paints out the code look of the buffer's own parse.
---@param buf integer
---@param lines string[] The buffer lines.
---@param block mkdocs_admonitions.Block
local function highlight_body(buf, lines, block)
  if block.body_end < block.body_start then
    return
  end
  local text, offsets = dedent(lines, block)
  local base = 110 + 20 * block.depth

  for row = block.body_start, block.body_end do
    local off = offsets[row - block.body_start]
    if off < #lines[row + 1] then
      vim.api.nvim_buf_set_extmark(buf, M.ns, row, off, {
        end_col = #lines[row + 1],
        hl_group = "MkdocsAdmonitionBody",
        priority = base,
        undo_restore = false,
        invalidate = true,
      })
    end
  end

  local last = block.body_end - block.body_start
  for _, c in ipairs(captures_of(text)) do
    -- A capture ending at column 0 of the row after the body stops at the body's last byte.
    local er, ec = c.er, c.ec
    if er > last then
      er, ec = last, #lines[block.body_start + last + 1] - offsets[last]
    end
    vim.api.nvim_buf_set_extmark(buf, M.ns, block.body_start + c.sr, offsets[c.sr] + c.sc, {
      end_row = block.body_start + er,
      end_col = ec == 0 and 0 or offsets[er] + ec,
      hl_group = c.hl,
      conceal = c.conceal,
      priority = base + 1 + c.offset,
      undo_restore = false,
      invalidate = true,
      strict = false,
    })
  end
end

---Mix two RGB colours.
---
---@param a integer
---@param b integer
---@param alpha number Share of `a`, from 0 to 1.
---@return integer
local function blend(a, b, alpha)
  local out = 0
  for shift = 16, 0, -8 do
    local ca = bit.band(bit.rshift(a, shift), 0xff)
    local cb = bit.band(bit.rshift(b, shift), 0xff)
    out = out + bit.lshift(math.floor(ca * alpha + cb * (1 - alpha) + 0.5), shift)
  end
  return out
end

---Define the highlight groups from the current `Normal` colours.
---
---The body group is foreground only, so CursorLine and inactive window
---backgrounds show through; title rows get a faint tint of their type.
local function define_highlights()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  vim.api.nvim_set_hl(0, "MkdocsAdmonitionBody", { fg = normal.fg, ctermfg = normal.ctermfg })

  -- A transparent terminal has no Normal background to blend into.
  local bg = normal.bg or (vim.o.background == "light" and 0xffffff or 0x000000)
  for kind, t in pairs(TYPES) do
    local group = group_of(kind)
    vim.api.nvim_set_hl(0, group, { fg = t.color })
    vim.api.nvim_set_hl(0, group .. "Title", { fg = t.color, bg = blend(t.color, bg, 0.15), bold = true })
  end
end

define_highlights()
-- `:colorscheme` clears custom groups.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("mkdocs_admonitions_hl", {}),
  callback = define_highlights,
})

---Draw every admonition of a buffer, replacing what was drawn before.
---
---@param buf integer
function M.render(buf)
  vim.api.nvim_buf_clear_namespace(buf, M.ns, 0, -1)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  for _, block in ipairs(M.parse(lines)) do
    draw_frame(buf, lines, block)
    highlight_body(buf, lines, block)
  end
end

---Tell whether a row lies in an admonition body.
---
---Scans the current lines instead of reading the last render, since markview
---and this module redraw on separate timers.
---@param buf integer
---@param row integer 0-based row.
---@return boolean
function M.covers(buf, row)
  for _, block in ipairs(M.parse(vim.api.nvim_buf_get_lines(buf, 0, -1, false))) do
    if row >= block.body_start and row <= block.body_end then
      return true
    end
  end
  return false
end

---Draw an indented code block for markview unless it is an admonition body.
---
---Installed as markview's `renderers.markdown_indented_code_block`, so it has
---to hand every other block to markview's own renderer.
---@param buf integer
---@param item table The parsed block markview passes to its renderers.
function M.markview_indented_code_block(buf, item)
  if M.covers(buf, item.range.row_start) then
    return
  end
  require("markview.renderers.markdown").indented_code_block(buf, item)
end

---Draw or clear a buffer's admonitions to match markview's preview.
---
---@param buf integer
function M.refresh(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end
  local ok_state, state = pcall(require, "markview.state")
  local ok_actions, actions = pcall(require, "markview.actions")
  local buf_state = ok_state and state.get_buffer_state(buf, false)
  if buf_state and buf_state.enable and ok_actions and actions.in_preview_mode() then
    M.render(buf)
  else
    vim.api.nvim_buf_clear_namespace(buf, M.ns, 0, -1)
  end
end

-- Pending debounced refresh per buffer; a newer edit supersedes an older one.
local pending = {}

---Refresh a buffer once edits have paused for markview's debounce.
---
---@param buf integer
local function refresh_later(buf)
  local ok, spec = pcall(require, "markview.spec")
  local delay = ok and spec.get({ "preview", "debounce" }, { fallback = 150, ignore_enable = true }) or 150
  local token = {}
  pending[buf] = token
  vim.defer_fn(function()
    if pending[buf] == token then
      pending[buf] = nil
      M.refresh(buf)
    end
  end, delay)
end

local group = vim.api.nvim_create_augroup("mkdocs_admonitions", {})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = { "MarkviewEnable", "MarkviewDisable", "MarkviewDetach" },
  callback = function(args)
    M.refresh(args.data and args.data.buffer or args.buf)
  end,
})

vim.api.nvim_create_autocmd({ "ModeChanged", "BufWinEnter" }, {
  group = group,
  callback = function(args)
    M.refresh(args.buf)
  end,
})

vim.api.nvim_create_autocmd("TextChanged", {
  group = group,
  callback = function(args)
    refresh_later(args.buf)
  end,
})

return M
