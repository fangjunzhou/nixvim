{ helpers, ... }:

{
  plugins.neo-tree = {
    enable = true;

    filesystem = {
      followCurrentFile = {
        enabled = true;
        leaveDirsOpen = false;
      };
    };

    settings = {
      commands.copy_absolute_path.__raw = ''
        function(state)
          local path = state.tree:get_node():get_id()
          vim.fn.setreg("+", path)
          vim.notify("Copied: " .. path)
        end
      '';
      commands.copy_relative_path.__raw = ''
        function(state)
          local path = state.tree:get_node():get_id()
          local relative_path = vim.fn.fnamemodify(path, ":.")
          vim.fn.setreg("+", relative_path)
          vim.notify("Copied: " .. relative_path)
        end
      '';
      window.mappings."h".__raw = ''
        function(state)
          local node = state.tree:get_node()
          if node.type == "directory" and node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end
      '';
      window.mappings."l".__raw = ''
        function(state)
          local node = state.tree:get_node()
          if node.type == "directory" then
            if not node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            elseif node:has_children() then
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        end
      '';
      window.mappings."gy" = "copy_relative_path";
      window.mappings."gY" = "copy_absolute_path";
      window.mappings."s" = "";
      window.mappings."<space>" = "";
    };
  };
  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>e";
      action = helpers.mkRaw ''
        function()
          require("neo-tree.command").execute({ toggle = true })
        end
      '';
      options = {
        desc = "Toggle Neo-Tree";
      };
    }
  ];
}
