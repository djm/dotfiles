{
  description = "djm's macOS system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Manage Homebrew installation via Nix
    brew-src = {
      url = "github:Homebrew/brew";
      flake = false;
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.brew-src.follows = "brew-src";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    macos-fuse-t-homebrew-cask = {
      url = "github:macos-fuse-t/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, nix-homebrew, ... }: {
    darwinConfigurations."elara" = nix-darwin.lib.darwinSystem {
      modules = [
        ./host/configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup-${self.sourceInfo.lastModifiedDate or "0"}";
          home-manager.users.djm = import ./home;
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "djm";
            taps = {
              "homebrew/homebrew-core" = inputs.homebrew-core;
              "homebrew/homebrew-cask" = inputs.homebrew-cask;
              "macos-fuse-t/homebrew-cask" = inputs.macos-fuse-t-homebrew-cask;
            };
            mutableTaps = false;
          };
        }
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
