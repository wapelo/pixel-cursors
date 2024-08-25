{
  description = "A cute, simplistic pixel art cursor theme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";

    hyprcursor = {
      url = "github:hyprwm/hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      hyprcursor,
      systems,
      ...
    }@inputs:
    let
      pkgs = nixpkgs;
      eachSystem = pkgs.lib.genAttrs (import systems);
    in
    {
      packages = eachSystem (system: {
        default = self.packages.${system}.pixel-cursors;

        mcmojave-hyprcursor = inputs.nixpkgs.legacyPackages.${system}.callPackage ./nix {
          inherit hyprcursor;
        };
      });

      formatter = eachSystem (system: nixpkgs.${system}.nixpkgs-format);
    };
}
