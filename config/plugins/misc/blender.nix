{ pkgs, ... }:

let
  nui-component = pkgs.vimUtils.buildVimPlugin
    {
      name = "nui-component";
      src = pkgs.fetchFromGitHub {
        owner = "grapp-dev";
        repo = "nui-components.nvim";
        rev = "v1.5.2";
        sha256 = "sha256-ZawV/0D9E+XCq/atuXGrVM2/LCWhDXmgt1n5jtXpCO8=";
      };
    };
  virt-column-nvim = pkgs.vimUtils.buildVimPlugin
    {
      name = "blender-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "fangjunzhou";
        repo = "blender.nvim";
        rev = "v0.1.0";
        sha256 = "sha256-rnM9iBLT/uOCvcyODb7Coj7aq2WedzXgixf8DHUmnqU=";
      };
    };
in
{
  extraPlugins = [
    nui-component
    virt-column-nvim
  ];

  extraConfigLua = ''
    require("blender").setup {
      profiles = { --                 Profile[]?       list of blender profiles
        --
        {
          name = "blender", --        string           profile name, must be unique
          cmd = "blender", --         string|string[]  command to run Blender
          -- use_launcher = true --   boolean?         whether to run the launcher.py script when starting Blender
          -- extra_args = {} --       string[]?        extra arguments to pass to Blender
          -- enable_dap = nil --      boolean?         whether to enable DAP for this profile (if nil, the global setting is used)
          -- watch = nil --           boolean?         whether to watch the add-on directory for changes (if nil, the global setting is used)
        },
      },
      dap = { --                      DapConfig?       DAP configuration
        enabled = true, --            boolean?         whether to enable DAP (can be overridden per profile)
      },
      notify = { --                   NotifyConfig?    notification configuration
        enabled = true, --            boolean?         whether to enable notifications
        verbosity = "INFO", --        "TRACE"|"DEBUG"|"INFO"|"WARN"|"ERROR"|"OFF"|vim.log.level?  log level for notifications
      },
      watch = { --                    WatchConfig?     file watcher configuration
        enabled = true, --            boolean?         whether to watch the add-on directory for changes (can be overridden per profile)
      },
    }
  '';
}
