{config, ...}: {
  imports = [../modules/desktop.nix];

  programs.bash = {
    enable = true;
    profileExtra = ''
      # Start Fish for interactive SSH logins after Bash loads the environment.
      if [[ $- == *i* && -n "$SSH_TTY" ]]; then
        exec ${config.programs.fish.package}/bin/fish --login
      fi
    '';
  };
}
