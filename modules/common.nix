{pkgs, ...}: {
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    age
    alejandra
    aria2
    bash-language-server
    bottom
    # comma # enabled through nix-index
    curl
    docker-compose-language-service
    duf
    dust
    file
    fzf
    git
    gocryptfs
    htop
    lazydocker
    lazygit
    lolcat
    nil
    nix-search-tv
    ouch
    p7zip
    ripgrep
    wget
    yaml-language-server
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionPath = [
    "$HOME/scripts"
  ];

  home.sessionVariables.EDITOR = "hx";

  # garbage collection for home-manager
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # atuin
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  # bat
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batpipe
      batwatch
      prettybat
    ];
    config = {
      paging = "never";
    };
  };

  programs.codex = {
    enable = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
  };

  programs.fastfetch = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      		set fish_greeting
    '';
    shellAbbrs = {
      hm = "home-manager";
      zz = "zellij";
    };
    shellAliases = {
      man = "batman --paging always";
      ls = "eza";
      cd = "z";
      ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      theme = "adwaita-dark";
    };
  };

  programs.herdr = {
    enable = true;
  };

  programs.micro = {
    enable = true;
    settings = {
      # colorscheme = "monokai";
      lsp.ignoreMessages = "LS message1 to ignore|LS message 2 to ignore|...";
      lsp.ignoreTriggerCharacters = "completion,signature";
      lsp = {
        autostart = true;
        server = {
          nix = {
            command = "nixd";
            args = [];
          };
        };
      };
    };
  };

  programs.nix-index-database.comma.enable = true;

  programs.nix-your-shell = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      nix_shell = {
        heuristic = true;
      };
    };
  };

  programs.tealdeer = {
    enable = true;
    enableAutoUpdates = true;
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    shellWrapperName = "yy";
    plugins.ouch = pkgs.yaziPlugins.ouch;
    settings = {
      plugin.prepend_previewers = [
        {
          mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
          run = "ouch";
        }
      ];
      opener.extract = [
        {
          run = "ouch d -y %s";
          desc = "Extract here with ouch";
          for = "unix";
        }
      ];
    };
    keymap.mgr.prepend_keymap = [
      {
        on = ["C"];
        run = "plugin ouch";
        desc = "Compress with ouch";
      }
    ];
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = false; # annoying with terminals in IDE's and such
    settings = {
      default_shell = "fish";
      on_force_close = "detach";
      copy_on_select = true;
      # theme = "default";
      show_startup_tips = false;
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
