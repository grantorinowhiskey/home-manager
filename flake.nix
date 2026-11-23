{
  description = "Home Manager configuration of jt";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nix-index-database,
    ...
  }: let
    mkHome = {
      user,
      host,
      system ? "x86_64-linux",
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./modules/common.nix
          ./users/${user}.nix
          ./hosts/${host}.nix
          nix-index-database.homeModules.default
        ];
      };
  in {
    homeConfigurations = {
      "jt@nix-t14" = mkHome {
        user = "jt";
        host = "nix-t14";
      };
      "deck@steamdeck" = mkHome {
        user = "deck";
        host = "steamdeck";
      };
      "deck@gabecube" = mkHome {
        user = "deck";
        host = "gabecube";
      };
      "jt@nix-n3" = mkHome {
        user = "jt";
        host = "nix-n3";
      };
      "jt@debian-hetzner" = mkHome {
        user = "jt";
        host = "debian-hetzner";
      };
    };
  };
}
