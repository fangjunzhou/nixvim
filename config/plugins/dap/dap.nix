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
      key = "<f17>";
      action = ''
        function()
        	require("dap").terminate()
        end
      '';
      lua = true;
      options = {
        desc = "DAP Terminate";
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
    {
      mode = [ "n" ];
      key = "<f21>";
      action = ''
        function()
        	require("dap").clear_breakpoints()
        end
      '';
      lua = true;
      options = {
        desc = "DAP Clear Breakpoints";
      };
    }
  ];

  extraConfigLua = ''
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  '';
}
