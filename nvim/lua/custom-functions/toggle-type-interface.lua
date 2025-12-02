local M = {}

local function split_preserving_generics(str, delimiter)
  local result = {}
  local current = ''
  local depth = 0

  for i = 1, #str do
    local char = str:sub(i, i)
    if char == '<' then
      depth = depth + 1
      current = current .. char
    elseif char == '>' then
      depth = depth - 1
      current = current .. char
    elseif char == delimiter and depth == 0 then
      local trimmed = current:gsub('^%s+', ''):gsub('%s+$', '')
      if trimmed ~= '' then
        result[#result + 1] = trimmed
      end
      current = ''
    else
      current = current .. char
    end
  end

  local trimmed = current:gsub('^%s+', ''):gsub('%s+$', '')
  if trimmed ~= '' then
    result[#result + 1] = trimmed
  end

  return result
end

function M.toggle_typescript_interface_type()
  local bufnr = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local all_lines = vim.api.nvim_buf_get_lines(bufnr, row - 1, -1, false)

  -- Find the complete declaration (might span multiple lines)
  local declaration = ''
  local start_line = row - 1
  local end_line = row - 1
  local found_end = false
  local generic_depth = 0

  for i, line in ipairs(all_lines) do
    declaration = declaration .. ' ' .. line
    end_line = row - 1 + i - 1

    -- Track generic depth
    for j = 1, #line do
      local char = line:sub(j, j)
      if char == '<' then
        generic_depth = generic_depth + 1
      elseif char == '>' then
        generic_depth = generic_depth - 1
      end
    end

    -- Found opening brace at depth 0 - we have the full declaration
    if line:match '{' and generic_depth == 0 then
      found_end = true
      break
    end
  end

  if not found_end then
    return
  end

  -- Normalize whitespace
  declaration = declaration:gsub('%s+', ' '):gsub('^%s+', ''):gsub('%s+$', '')

  local indent = all_lines[1]:match '^(%s*)' or ''
  local new_line

  -- Check if it's an interface
  if declaration:match 'interface ' then
    local export = declaration:match '^export ' and 'export ' or ''
    local name, extends_part = declaration:match 'interface ([%w_]+) extends ([^{]+) {'

    if name and extends_part then
      local types = split_preserving_generics(extends_part, ',')
      new_line = indent .. export .. 'type ' .. name .. ' = ' .. table.concat(types, ' & ') .. ' & {'
    else
      -- Simple interface without extends
      name = declaration:match 'interface ([%w_]+) {'
      if name then
        new_line = indent .. export .. 'type ' .. name .. ' = {'
      end
    end
  -- Check if it's a type
  elseif declaration:match 'type ' then
    local export = declaration:match '^export ' and 'export ' or ''

    -- Check for intersection with brace
    local name, intersections = declaration:match 'type ([%w_]+) = ([^{]+) & {'

    if name and intersections then
      local types = split_preserving_generics(intersections, '&')
      new_line = indent .. export .. 'interface ' .. name .. ' extends ' .. table.concat(types, ', ') .. ' {'
    else
      -- Simple type with brace
      name = declaration:match 'type ([%w_]+) = {'
      if name then
        new_line = indent .. export .. 'interface ' .. name .. ' {'
      end
    end
  end

  if new_line then
    vim.api.nvim_buf_set_lines(bufnr, start_line, end_line + 1, false, { new_line })
  end
end

return M
