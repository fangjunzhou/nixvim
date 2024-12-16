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
      servers = {
        python = ''
          function(cb, config)
            if config.request == "attach" then
              ---@diagnostic disable-next-line: undefined-field
              local port = (config.connect or config).port
              ---@diagnostic disable-next-line: undefined-field
              local host = (config.connect or config).host or "127.0.0.1"
              cb({
                type = "server",
                port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                host = host,
                options = {
                  source_filetype = "python",
                },
              })
            else
              cb({
                type = "executable",
                command = os.getenv("VIRTUAL_ENV") .. "/bin/python",
                args = { "-m", "debugpy.adapter" },
                options = {
                  source_filetype = "python",
                },
              })
            end
          end
        '';
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
      python = [
        {
          name = "Launch Python File";
          type = "python";
          request = "launch";
          program = "\${file}";
          pythonPath.__raw = ''
            function()
              -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
              -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
              -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
              elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
              else
                return '/usr/bin/python'
              end
            end
          '';
        }
        {
          name = "Attach to Python Process";
          type = "python";
          request = "attach";
          connect = {
            host = "127.0.0.1";
            port = 5678; # Ensure this matches your debugpy setup
          };
          mode = "remote";
          cwd = "\${workspaceFolder}";
          pathMappings = [
            {
              localRoot = "\${workspaceFolder}"; # Adjust to match your local path
              remoteRoot = "."; # Adjust to match the remote path
            }
          ];
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
