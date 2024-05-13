{
  plugins.dap = {
    enable = true;
    configurations = {
      java = [
        {
          type = "java";
          request = "launch";
          name = "Launch Java Main Class";
        }
      ];
    };
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
      key = "<f5>";
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
