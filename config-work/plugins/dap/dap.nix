{ pkgs, helpers, ... }:

{
  plugins.dap = {
    enable = true;
    adapters = {
      executables = {
        lldb = {
          command = "${pkgs.llvmPackages.lldb}/bin/lldb-vscode";
          args = [
            "-i"
            "dap"
          ];
        };
      };
    };
    configurations = {
      objc = [
        {
          name = "attach-remote-lldb-server";
          type = "lldb";
          request = "attach";
          program.__raw = ''
            function()
              local executable = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
              vim.g.dap_executable = executable
              return executable
            end
          '';
          gdb-remote-port.__raw = ''
            function()
              local port = vim.fn.input("GDB Remote Port: ", "9000")
              return port
            end
          '';
          gdb-remote-hostname.__raw = ''
            function()
              local hostname = vim.fn.input("GDB Remote Hostname: ", "localhost")
              return hostname
            end
          '';
          cwd = "\${workspaceFolder}";
          stopAtBeginningOfMainSubprogram = true;
          showDisassembly = "never";
        }
      ];
    };
  };
  plugins.dap-ui.enable = true;

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
    {
      mode = [ "n" ];
      key = "<leader>su";
      action = helpers.mkRaw ''
        function()
        	require("dap").up()
        end
      '';
      options = {
        desc = "DAP Stack Up";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>sd";
      action = helpers.mkRaw ''
        function()
        	require("dap").down()
        end
      '';
      options = {
        desc = "DAP Stack Down";
      };
    }
  ];

  extraConfigLua = ''
    -- Dap UI.
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
