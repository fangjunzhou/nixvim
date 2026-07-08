{
  plugins.snacks = {
    enable = true;
  };

  plugins.opencode = {
    enable = true;
  };

  extraConfigLua = ''
    require("snacks").setup({
      input = {
        enabled = true, -- Enhances Ask
      },
      picker = {
        enabled = true, -- Enhances Select
        win = {
          input = {
            keys = {
              ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
            },
          },
        },
        actions = {
          opencode_send = function(picker) ---@param picker snacks.Picker
            local items = vim.tbl_map(function(item) ---@param item snacks.picker.Item
              if item.resolve then
                item.resolve(item)
              end

              return item.file
                and require("opencode.context").format({
                  path = item.file,
                  start_line = item.pos and item.pos[1] or nil,
                  start_col = item.pos and item.pos[2] + 1 or nil,
                  end_line = item.end_pos and item.end_pos[1] or nil,
                  end_col = item.end_pos and item.end_pos[2] + 1 or nil,
                })
                or item.text
            end, picker:selected({ fallback = true }))

            require("opencode").prompt(table.concat(items, ", ") .. " ")
          end,
        },
      },
    })

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type for details
    }

    vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`

    -- Recommended/example keymaps
    vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end, { desc = "Ask OpenCode…" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end,       { desc = "Select OpenCode…" })

    local opencode_operator_prompt = "@this "
    _G.nixvim_opencode_prompt_operator = function(kind)
      local start = vim.api.nvim_buf_get_mark(0, "[")
      local finish = vim.api.nvim_buf_get_mark(0, "]")
      local location = require("opencode.context").format({
        buf = vim.api.nvim_get_current_buf(),
        start_line = start[1],
        start_col = kind == "line" and nil or start[2] + 1,
        end_line = finish[1],
        end_col = kind == "line" and nil or finish[2] + 1,
      })

      local prompt = opencode_operator_prompt:gsub("@this", location)
      require("opencode").prompt(prompt)
    end

    local function opencode_operator(prompt)
      opencode_operator_prompt = prompt
      vim.go.operatorfunc = "v:lua.nixvim_opencode_prompt_operator"
      return "g@"
    end

    vim.keymap.set({ "n", "x" }, "go",  function() return opencode_operator("@this ") end,        { desc = "Append range to OpenCode", expr = true })
    vim.keymap.set("n",          "goo", function() return opencode_operator("@this ") .. "_" end, { desc = "Append line to OpenCode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll OpenCode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll OpenCode down" })
  '';
}
