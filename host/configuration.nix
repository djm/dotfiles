{ ... }:

{
  imports = [
    ./packages.nix
    ./macos.nix
    ./homebrew.nix
  ];

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Zsh as system shell
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;

  # Enable Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # The user that runs darwin-rebuild
  system.primaryUser = "djm";

  # Set once on first install, do not change
  system.stateVersion = 6;

  # The platform the configuration will be used on (aarch64 = Apple Silicon)
  nixpkgs.hostPlatform = "aarch64-darwin";
}
