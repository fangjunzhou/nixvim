{ pkgs-lldb, helpers, ... }:

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
      action = helpers.mkRaw ''
        function()
        	require("dap").continue()
        end
      '';
      options = {
        desc = "DAP Continue";
      };
    }
    {
      mode = [ "n" ];
      key = "<f17>";
      action = helpers.mkRaw ''
        function()
        	require("dap").terminate()
        end
      '';
      options = {
        desc = "DAP Terminate";
      };
    }
    {
      mode = [ "n" ];
      key = "<f10>";
      action = helpers.mkRaw ''
        function()
        	require("dap").step_over()
        end
      '';
      options = {
        desc = "DAP Step Over";
      };
    }
    {
      mode = [ "n" ];
      key = "<f11>";
      action = helpers.mkRaw ''
        function()
        	require("dap").step_into()
        end
      '';
      options = {
        desc = "DAP Step Into";
      };
    }
    {
      mode = [ "n" ];
      key = "<f12>";
      action = helpers.mkRaw ''
        function()
        	require("dap").step_out()
        end
      '';
      options = {
        desc = "DAP Step Out";
      };
    }
    {
      mode = [ "n" ];
      key = "<f9>";
      action = helpers.mkRaw ''
        function()
        	require("dap").toggle_breakpoint()
        end
      '';
      options = {
        desc = "DAP Toggle Breakpoints";
      };
    }
    {
      mode = [ "n" ];
      key = "<f21>";
      action = helpers.mkRaw ''
        function()
        	require("dap").clear_breakpoints()
        end
      '';
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
