local M = {}

----------------------------------------------------------------------
-- utilities
----------------------------------------------------------------------

local function get_text(node, bufnr)
  return vim.treesitter.get_node_text(node, bufnr)
end

----------------------------------------------------------------------
-- package
----------------------------------------------------------------------

local function extract_package(root, bufnr)
  for child in root:iter_children() do
    if child:type() == "package_declaration" then
      -- safer: search inside children
      for sub in child:iter_children() do
        if sub:type() == "scoped_identifier" or sub:type() == "identifier" then
          return get_text(sub, bufnr)
        end
      end

      -- fallback: last resort
      return get_text(child, bufnr)
    end
  end

  return ""
end

----------------------------------------------------------------------
-- node factory
----------------------------------------------------------------------

local function make_node(opts)
  return {
    name = opts.name,
    display_name = opts.display_name or opts.name,
    path = opts.path,
    type = opts.type,
    icon = opts.icon,
    children = opts.children or {},
  }
end

----------------------------------------------------------------------
-- helpers
----------------------------------------------------------------------

local function join_package(pkg, class_path)
  if pkg == "" then
    return class_path
  end
  return pkg .. "." .. class_path
end

----------------------------------------------------------------------
-- METHOD
----------------------------------------------------------------------

local function build_method(node, bufnr, pkg, class_path)
  local name_node = node:field("name")[1]
  if not name_node then
    return nil
  end

  local name = get_text(name_node, bufnr)

  local full_class = join_package(pkg, class_path)

  return make_node({
    name = name,
    display_name = name,
    -- METHOD MUST USE DOT
    path = full_class .. "." .. name,
    type = "method",
    icon = "󰊕",
  })
end

----------------------------------------------------------------------
-- CLASS (handles nested + top-level)
----------------------------------------------------------------------

local function build_class(node, bufnr, pkg, class_stack)
  local name_node = node:field("name")[1]
  if not name_node then
    return nil
  end

  local name = get_text(name_node, bufnr)

  local new_stack = vim.deepcopy(class_stack)
  table.insert(new_stack, name)

  --------------------------------------------------------------------
  -- determine class separator rules
  --------------------------------------------------------------------

  local class_path = table.concat(new_stack, "$") -- nested uses $
  local full_class_path = join_package(pkg, class_path)

  local class_node = make_node({
    name = name,
    display_name = name,
    path = full_class_path,
    type = "class",
    icon = "󰅩",
  })

  --------------------------------------------------------------------
  -- traverse class body
  --------------------------------------------------------------------

  local body
  for child in node:iter_children() do
    if child:type() == "class_body" then
      body = child
      break
    end
  end

  if not body then
    return class_node
  end

  for child in body:iter_children() do
    local t = child:type()

    if t == "method_declaration" then
      local m = build_method(child, bufnr, pkg, class_path)
      if m then
        table.insert(class_node.children, m)
      end
    elseif t == "class_declaration" then
      local c = build_class(child, bufnr, pkg, new_stack)
      if c then
        table.insert(class_node.children, c)
      end
    end
  end

  return class_node
end

----------------------------------------------------------------------
-- ENTRY POINT
----------------------------------------------------------------------

function M.get_items()
  local bufnr = vim.api.nvim_get_current_buf()

  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "java")
  if not ok or not parser then
    vim.notify("Java Treesitter parser not available", vim.log.levels.ERROR)
    return {}
  end

  local tree = parser:parse()[1]
  local root = tree:root()

  local pkg = extract_package(root, bufnr)

  local root_node = make_node({
    name = pkg ~= "" and pkg or "[default]",
    display_name = pkg ~= "" and pkg or "[default]",
    path = pkg,
    type = "package",
    icon = "󰏗",
    children = {},
  })

  --------------------------------------------------------------------
  -- walk file
  --------------------------------------------------------------------

  local function walk(node)
    if node:type() == "class_declaration" then
      local class = build_class(node, bufnr, pkg, {})
      if class then
        table.insert(root_node.children, class)
      end
      return
    end

    for child in node:iter_children() do
      walk(child)
    end
  end

  walk(root)

  return { root_node }
end

return M
