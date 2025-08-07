{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jt";
  home.homeDirectory = "/home/jt";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    alejandra
    aria2
    bottom
    comma
    curl
    docker-compose-language-service
    fastfetch
    fzf
    git
    htop
    lazydocker
    lazygit
    nil
    nix-search-tv
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jt/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
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
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
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
  		man = "batman";
  		cat = "bat --paging=never";
  		ls = "eza";
      cd = "z";
      ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
  	};
  };

  programs.helix = {
  	enable = true;
    settings = {
      theme = "adwaita-dark";
    };
  };

  programs.micro = {
    enable = true;
    settings = {
      colorscheme = "monokai";
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

  programs.mpv = {
  	enable = true;
  	config = {
  		hwdec = "auto-safe";
  		vo = "gpu";
  		profile = "gpu-hq";
  		save-position-on-quit = "true";
  	};
  };

  programs.nix-your-shell = {
  	enable = true;
  	enableFishIntegration = true;
  };

  programs.starship = {
  	enable = true;
  	enableFishIntegration = true;
  };

  programs.tealdeer = {
    enable = true;
    enableAutoUpdates = true;
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
  };

  programs.zellij = {
  	enable = true;
  	enableFishIntegration = false; # annoying with terminals in IDE's and such
  	settings = {
  		default_shell = "fish";
  		on_force_close = "detach";
  		copy_command = "default";
  		copy_on_select = false;
  		theme = "default";
  		show_startup_tips = false;
  	};
  };

  programs.zoxide = {
  	enable = true;
  	enableFishIntegration = true;
  };

}
