return {
	'nvim-telescope/telescope.nvim', branch = '0.1.x',
	dependencies = { 
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-fzf-native.nvim',
	},
	event = "VeryLazy",
	optional = true,
	opts = function(_, opts)
      local function flash(prompt_bufnr)
        require("flash").jump({
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
              end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        })
      end
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          n = { s = flash },
          i = { ["<c-s>"] = flash },
        },
      })
    end,
	config = function()
		local previewers = require("telescope.previewers")
		local actions = require("telescope.actions")
		local Job = require("plenary.job")

		local new_maker = function(filepath, bufnr, opts)
		  filepath = vim.fn.expand(filepath)
		  Job:new({
			 command = "file",
			 args = { "--mime-type", "-b", filepath },
			 on_exit = function(j)
				local mime_type = vim.split(j:result()[1], "/")[1]
				if mime_type == "text" then
				  previewers.buffer_previewer_maker(filepath, bufnr, opts)
				else
				  -- maybe we want to write something to the buffer here
				  vim.schedule(function()
					 vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
				  end)
				end
			 end
		  }):sync()
		  opts = opts or {}

		  vim.loop.fs_stat(filepath, function(_, stat)
			 if not stat then return end
			 if stat.size > 100000 then
				return
			 else
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			 end
		  end)
		end
		require('telescope').setup{
		  defaults = {
			buffer_previewer_maker = new_maker,
			 mappings = {
				n = {
				  ["<C-y>"] = require("telescope.actions.layout").toggle_preview,
				},
				i = {
				  ["<C-y>"] = require("telescope.actions.layout").toggle_preview,
				  ["<C-u>"] = false,
				  ["<C-s>"] = actions.cycle_previewers_next,
				  ["<C-a>"] = actions.cycle_previewers_prev,
				},
			 },
			 extensions = {
    			fzf = {
      			fuzzy = true,                    -- false will only do exact matching
      			override_generic_sorter = true,  -- override the generic sorter
      			override_file_sorter = true,     -- override the file sorter
      			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    			}
  			},
			 prompt_prefix = "   ",
			 selection_caret = "  ",
			 multi_icon = "",
			 sorting_strategy = "ascending",
			 layout_strategy = nil,
			 layout_config = nil,
			 borderchars = {
				"─",
				"│",
				"─",
				"│",
				"┌",
				"┐",
				"┘",
				"└",
			 },
			 color_devicons = true,
			 set_env = { ["COLORTERM"] = "truecolor" },
			 vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob",
				"!**/.git/*",
				"--trim",
			 },
		  },
		  pickers = {
			 buffers = {
				previewer = true,
				layout_config = {
				  width = 0.9,
				  prompt_position = "top",
				},
				find_files = {
					mappings = {
						n = {
							["cd"] = function(prompt_bufnr)
							local selection = require("telescope.actions.state").get_selected_entry()
							local dir = vim.fn.fnamemodify(selection.path, ":p:h")
							require("telescope.actions").close(prompt_bufnr)
							-- Depending on what you want put `cd`, `lcd`, `tcd`
							vim.cmd(string.format("silent lcd %s", dir))
						end
						}
					}
				},
			 },
			 builtin = {
				previewer = true,
				layout_config = {
				  width = 0.95,
				  prompt_position = "top",
				},
			 },
			 find_files = {
				previewer = true,
				layout_config = {
				  width = 0.9,
				  prompt_position = "top",
				},
			 },
			 help_tags = {
				layout_config = {
				  prompt_position = "top",
				  scroll_speed = 4,
				  height = 0.9,
				  width = 0.9,
				  preview_width = 0.55,
				},
			 },
			 live_grep = {
				layout_strategy = "vertical",
				layout_config = {
				  width = 0.95,
				  height = 0.95,
				  preview_cutoff = 1,
				  mirror = false,
				},
			 },
			 lsp_implementations = {
				layout_strategy = "vertical",
				layout_config = {
				  width = 0.95,
				  height = 0.95,
				  preview_cutoff = 1,
				  mirror = false,
				},
			 },
			 lsp_references = {
				layout_strategy = "vertical",
				layout_config = {
				  width = 0.95,
				  height = 0.95,
				  preview_cutoff = 1,
				  mirror = false,
				},
			 },
			 oldfiles = {
				previewer = true,
				layout_config = {
				  width = 0.9,
				  prompt_position = "top",
				},
			 },
		  },
	  }
		require('telescope').load_extension('fzf')
		require("telescope.pickers.layout_strategies").buffer_window = function(self)
		  local layout = require("telescope.pickers.window").get_initial_window_options(self)
		  local prompt = layout.prompt
		  local results = layout.results
		  local preview = layout.preview
		  local config = self.layout_config
		  local padding = self.window.border and 2 or 0
		  local width = vim.api.nvim_win_get_width(self.original_win_id)
		  local height = vim.api.nvim_win_get_height(self.original_win_id)
		  local pos = vim.api.nvim_win_get_position(self.original_win_id)
		  local wline = pos[1] + 1
		  local wcol = pos[2] + 1
		  
		  -- Height
		  prompt.height = 1
		  preview.height = self.previewer and math.floor(height * 0.4) or 0
		  results.height = height
			 - padding
			 - (prompt.height + padding)
			 - (self.previewer and (preview.height + padding) or 0)
		  
		  -- Line
		  local rows = {}
		  local mirror = config.mirror == true
		  local top_prompt = config.prompt_position == "top"
		  if mirror and top_prompt then
			 rows = { prompt, results, preview }
		  elseif mirror and not top_prompt then
			 rows = { results, prompt, preview }
		  elseif not mirror and top_prompt then
			 rows = { preview, prompt, results }
		  elseif not mirror and not top_prompt then
			 rows = { preview, results, prompt }
		  end
		  local next_line = 1 + padding / 2
		  for k, v in pairs(rows) do
			 if v.height ~= 0 then
				v.line = next_line
				next_line = v.line + padding + v.height
			 end
		  end
		  
		  -- Width
		  prompt.width = width - padding
		  results.width = prompt.width
		  preview.width = prompt.width
		  
		  -- Col
		  prompt.col = wcol + padding / 2
		  results.col = prompt.col
		  preview.col = prompt.col
		  
		  if not self.previewer then
			 layout.preview = nil
		  end
		  
		  return layout
		end
	end
}
