{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let 
    configuration = { pkgs, ... }: {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
      # Used for backwards compatibility, please read the changelog before changing.
      system.stateVersion = 5;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#JOs-Mac-Studio
    darwinConfigurations."JOs-Mac-Studio" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        ./nix-darwin.nix
        ./homebrew.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.doongle = import ./home-manager.nix;
        }
      ];
      
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."JOs-Mac-Studio".pkgs;
  };
}
