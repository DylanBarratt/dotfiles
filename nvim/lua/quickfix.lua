-- Quickfix save/load functionality for Neovim
-- vibe coded

local M = {}

-- Default directory for storing quickfix files
local qf_dir = vim.fn.stdpath("data") .. "/quickfix"

-- Ensure the quickfix directory exists
vim.fn.mkdir(qf_dir, "p")

-- Save current quickfix list to a file
function M.save_quickfix(filename)
  local qf_list = vim.fn.getqflist()

  if #qf_list == 0 then
    vim.notify("Quickfix list is empty", vim.log.levels.WARN)
    return
  end

  -- Default filename if not provided
  if not filename then
    filename = "quickfix_" .. os.date("%Y%m%d_%H%M%S") .. ".json"
  end

  -- Add .json extension if not present
  if not filename:match("%.json$") then
    filename = filename .. ".json"
  end

  local filepath = qf_dir .. "/" .. filename

  -- Convert quickfix list to JSON-serializable format
  local qf_data = {
    timestamp = os.date("%Y-%m-%d %H:%M:%S"),
    count = #qf_list,
    items = {},
  }

  for i, item in ipairs(qf_list) do
    -- Get filename from buffer number if filename is empty
    local filename = item.filename or ""
    if filename == "" and item.bufnr and item.bufnr > 0 then
      filename = vim.api.nvim_buf_get_name(item.bufnr)
    end

    table.insert(qf_data.items, {
      filename = filename,
      lnum = item.lnum or 0,
      col = item.col or 0,
      text = item.text or "",
      type = item.type or "",
      valid = item.valid or 0,
      module = item.module or "",
      nr = item.nr or 0,
      pattern = item.pattern or "",
      vcol = item.vcol or 0,
      -- Note: bufnr is intentionally excluded for portability
    })
  end

  -- Write to file
  local file = io.open(filepath, "w")
  if file then
    file:write(vim.json.encode(qf_data))
    file:close()
    vim.notify("Quickfix list saved to: " .. filename, vim.log.levels.INFO)
  else
    vim.notify("Error: Could not save quickfix list", vim.log.levels.ERROR)
  end
end

-- Load quickfix list from a file
function M.load_quickfix(filename)
  if not filename then
    vim.notify("Please provide a filename", vim.log.levels.WARN)
    return
  end

  -- Add .json extension if not present
  if not filename:match("%.json$") then
    filename = filename .. ".json"
  end

  local filepath = qf_dir .. "/" .. filename

  -- Check if file exists
  if vim.fn.filereadable(filepath) == 0 then
    vim.notify("File not found: " .. filename, vim.log.levels.ERROR)
    return
  end

  -- Read file
  local file = io.open(filepath, "r")
  if not file then
    vim.notify("Error: Could not read file", vim.log.levels.ERROR)
    return
  end

  local content = file:read("*all")
  file:close()

  -- Parse JSON
  local ok, qf_data = pcall(vim.json.decode, content)
  if not ok then
    vim.notify("Error: Invalid JSON in file", vim.log.levels.ERROR)
    return
  end

  -- Set quickfix list (bufnr will be resolved automatically by Neovim)
  vim.fn.setqflist({}, "r", {
    title = "Loaded: " .. filename .. " (" .. qf_data.count .. " items)",
    items = qf_data.items,
  })

  -- Open quickfix window
  vim.cmd("copen")

  vim.notify(
    "Loaded quickfix list: " .. filename .. " (" .. qf_data.count .. " items)",
    vim.log.levels.INFO
  )
end

-- List available quickfix files
function M.list_quickfix_files()
  local files = vim.fn.glob(qf_dir .. "/*.json", false, true)

  if #files == 0 then
    vim.notify("No saved quickfix files found", vim.log.levels.INFO)
    return
  end

  print("Available quickfix files:")
  for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ":t")
    print("  " .. filename)
  end
end

-- Delete a quickfix file
function M.delete_quickfix(filename)
  if not filename then
    vim.notify("Please provide a filename", vim.log.levels.WARN)
    return
  end

  -- Add .json extension if not present
  if not filename:match("%.json$") then
    filename = filename .. ".json"
  end

  local filepath = qf_dir .. "/" .. filename

  if vim.fn.filereadable(filepath) == 0 then
    vim.notify("File not found: " .. filename, vim.log.levels.ERROR)
    return
  end

  vim.fn.delete(filepath)
  vim.notify("Deleted quickfix file: " .. filename, vim.log.levels.INFO)
end

-- Create user commands
vim.api.nvim_create_user_command("QfSave", function(opts)
  M.save_quickfix(opts.args)
end, {
  nargs = "?",
  desc = "Save current quickfix list to file",
})

vim.api.nvim_create_user_command("QfLoad", function(opts)
  M.load_quickfix(opts.args)
end, {
  nargs = 1,
  desc = "Load quickfix list from file",
  complete = function()
    local files = vim.fn.glob(qf_dir .. "/*.json", false, true)
    local completions = {}
    for _, file in ipairs(files) do
      local filename = vim.fn.fnamemodify(file, ":t:r") -- Remove path and extension
      table.insert(completions, filename)
    end
    return completions
  end,
})

vim.api.nvim_create_user_command("QfList", function()
  M.list_quickfix_files()
end, {
  desc = "List available quickfix files",
})

vim.api.nvim_create_user_command("QfDelete", function(opts)
  M.delete_quickfix(opts.args)
end, {
  nargs = 1,
  desc = "Delete a quickfix file",
  complete = function()
    local files = vim.fn.glob(qf_dir .. "/*.json", false, true)
    local completions = {}
    for _, file in ipairs(files) do
      local filename = vim.fn.fnamemodify(file, ":t:r") -- Remove path and extension
      table.insert(completions, filename)
    end
    return completions
  end,
})

-- Keymaps
vim.keymap.set("n", "<leader>qs", function()
  vim.ui.input({ prompt = "Save quickfix as: " }, function(input)
    if input then
      M.save_quickfix(input)
    end
  end)
end, { desc = "Save quickfix list" })

vim.keymap.set("n", "<leader>qd", function()
  local files = vim.fn.glob(qf_dir .. "/*.json", false, true)
  if #files == 0 then
    vim.notify("No saved quickfix files found", vim.log.levels.INFO)
    return
  end

  local filenames = {}
  for _, file in ipairs(files) do
    table.insert(filenames, vim.fn.fnamemodify(file, ":t:r"))
  end

  vim.ui.select(filenames, {
    prompt = "Delete quickfix file:",
  }, function(choice)
    if choice then
      M.delete_quickfix(choice)
    end
  end)
end, { desc = "Delete quickfix list" })

vim.keymap.set("n", "<leader>ql", function()
  local files = vim.fn.glob(qf_dir .. "/*.json", false, true)
  if #files == 0 then
    vim.notify("No saved quickfix files found", vim.log.levels.INFO)
    return
  end

  local filenames = {}
  for _, file in ipairs(files) do
    table.insert(filenames, vim.fn.fnamemodify(file, ":t:r"))
  end

  vim.ui.select(filenames, {
    prompt = "Load quickfix file:",
  }, function(choice)
    if choice then
      M.load_quickfix(choice)
    end
  end)
end, { desc = "Load quickfix list" })

return M
