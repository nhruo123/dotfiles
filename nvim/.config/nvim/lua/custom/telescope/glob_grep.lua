local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local make_entry = require 'telescope.make_entry'
local utils = require 'telescope.utils'
local sorters = require 'telescope.sorters'

local action_state = require 'telescope.actions.state'

local has_rg_program = function(picker_name, program)
  if vim.fn.executable(program) == 1 then
    return true
  end

  utils.notify(picker_name, {
    msg = string.format(
      "'ripgrep', or similar alternative, is a required dependency for the %s picker. "
        .. 'Visit https://github.com/BurntSushi/ripgrep#installation for installation instructions.',
      picker_name
    ),
    level = 'ERROR',
  })
  return false
end

local glob_grep = function(opts)
  opts = opts or {}

  local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
  if not has_rg_program('live_grep', vimgrep_arguments[1]) then
    return
  end

  local search_dirs = opts.search_dirs
  opts.cwd = opts.cwd and utils.path_expand(opts.cwd) or vim.loop.cwd()

  local additional_args = {}
  if opts.additional_args ~= nil then
    if type(opts.additional_args) == 'function' then
      additional_args = opts.additional_args(opts)
    elseif type(opts.additional_args) == 'table' then
      additional_args = opts.additional_args
    end
  end

  if opts.type_filter then
    additional_args[#additional_args + 1] = '--type=' .. opts.type_filter
  end

  if opts.file_encoding then
    additional_args[#additional_args + 1] = '--encoding=' .. opts.file_encoding
  end

  local args = utils.flatten { vimgrep_arguments, additional_args }

  local is_searching = true
  local previous_title = ''
  local glob = ''
  local previous_prompt = ''

  ---@param prompt_bufnr number: The prompt bufnr
  local change_mode = function(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    if is_searching then
      previous_title = current_picker.prompt_title
      previous_prompt = current_picker:_get_prompt()

      current_picker.prompt_border:change_title 'Set Glob'
      current_picker:set_prompt(glob)
    else
      previous_title = current_picker.prompt_title
      glob = current_picker:_get_prompt()

      current_picker.prompt_border:change_title(previous_title)
      current_picker:set_prompt(previous_prompt)
      current_picker:refresh()
    end

    is_searching = not is_searching
  end

  local live_grepper = finders.new_job(function(prompt)
    if (not prompt or prompt == '') and is_searching then
      return nil
    end

    if not is_searching then
      glob = prompt
    else
      previous_prompt = prompt
    end

    if glob == '' then
      return utils.flatten { args, '--', previous_prompt, search_dirs }
    else
      return utils.flatten { args, '--glob', glob, '--', previous_prompt, search_dirs }
    end
  end, make_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd)
  local custom_sorter = function()
    local fzy = require 'telescope.algos.fzy'

    return sorters.Sorter:new {
      scoring_function = function()
        return 1
      end,

      highlighter = function(_, _, display)
        return fzy.positions(previous_prompt, display)
      end,
    }
  end
  pickers
    .new(opts, {
      prompt_title = 'Live Grep',
      finder = live_grepper,
      previewer = conf.grep_previewer(opts),
      sorter = custom_sorter(),
      attach_mappings = function(_, map)
        map('i', '<c-f>', change_mode)
        return true
      end,
      push_cursor_on_edit = true,
    })
    :find()
end

return glob_grep
