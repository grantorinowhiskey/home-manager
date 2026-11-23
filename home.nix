{...}: {
  # Compatibility entry point for the original laptop configuration.
  imports = [
    ./modules/common.nix
    ./users/jt.nix
    ./hosts/nix-t14.nix
  ];
}
