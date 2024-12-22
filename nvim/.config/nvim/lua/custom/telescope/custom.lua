local M = {}
M.glob_grep = require 'custom.telescope.glob_grep'

-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local is_inside_work_tree = {}

M.project_files = function(opts)
  opts = opts or {}

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system 'git rev-parse --is-inside-work-tree'
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    require('telescope.builtin').git_files(opts)
  else
    require('telescope.builtin').find_files(opts)
  end
end

return M
