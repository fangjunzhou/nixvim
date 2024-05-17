{ pkgs-lldb, ... }:

{
  plugins.dap = {
    enable = true;
    adapters = {
      executables = {
        lldb = {
          command = "${pkgs-lldb.llvmPackages.lldb}/bin/lldb-vscode";
          args = [
            "-i"
            "dap"
          ];
        };
      };
    };
    configurations = {
      java = [
        {
          name = "Launch Java Main Class";
          type = "java";
          request = "launch";
        }
      ];
      cpp = [
        {
          name = "Launch C++ Executable";
          type = "lldb";
          request = "launch";
          program.__raw = ''
            function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end
          '';
          cwd = "\${workspaceFolder}";
          stopAtBeginningOfMainSubprogram = true;
          args = { };
        }
      ];
    };
    extensions.dap-ui.enable = true;
  };

  keymaps = [
    {
      mode = [ "n" ];
      key = "<f5>";
      action = ''
        function()
        	require("dap").continue()
        end
      '';
      lua = true;
      options = {
        desc = "DAP Continue";
      };
    }
    {
      mode = [ "n" ];
      key = "<f10>";
      action = ''
        function()
        	require("dap").step_over()
        end
      '';
      lua = true;
      options = {
        desc = "DAP Step Over";
      };
    }
    {
      mode = [ "n" ];
      key = "<f11>";
      action = ''
        function()
        	require("dap").step_into()
        end
      '';
      lua = true;
      options = {
        desc = "DAP Step Into";
      };
    }
    {
      mode = [ "n" ];
      key = "<f12>";
      action = ''
        function()
        	require("dap").step_out()
        end
      '';
      lua = true;
      options = {
        desc = "DAP Step Out";
      };
    }
    {
      mode = [ "n" ];
      key = "<f9>";
      action = ''
        function()
        	require("dap").toggle_breakpoint()
        end
      '';
      lua = true;
      options = {
        desc = "DAP Toggle Breakpoints";
      };
    }
  ];
}
