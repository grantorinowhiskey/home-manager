{pkgs, ...}: {
  home.packages = [pkgs.wl-clipboard];

  home.sessionVariables = {
    TERMINAL = "ghostty";
    GTK_IM_MODULE = "simple"; # workaround for dead keys i ghostty
  };

  systemd.user.sessionVariables = {
    GTK_IM_MODULE = "simple"; # workaround for dead keys i ghostty
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = ["ghostty +new-window"];
    };
  };

  programs.ghostty = {
    enable = true;
    systemd.enable = true;
    # settings = {
    #   # Font configuration
    #   font-size = 14;
    #   font-family = "Hack Nerd Font Mono";
    #   # theme
    #   # theme = "dankcolors";

    # };
  };

  # Ghostty 1.3.1 declares Type=notify-reload, but does not install its
  # SIGUSR2 handler early enough for systemd's startup validation.
  xdg.configFile."systemd/user/app-com.mitchellh.ghostty.service.d/notify-workaround.conf".text = ''
    [Service]
    Type=notify
  '';

  programs.mpv = {
    enable = true;
    config = {
      hwdec = "auto-safe";
      vo = "gpu";
      profile = "gpu-hq";
      save-position-on-quit = "true";
    };
  };

  programs.zellij.settings.copy_command = "wl-copy";
}
