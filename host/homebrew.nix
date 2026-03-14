{ ... }:

{
  # Homebrew is used ONLY for macOS GUI apps (casks) that Nix can't install.
  # All CLI tools should go in darwin.nix or home.nix instead.
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      # Uninstall anything installed via brew that isn't listed in this file
      cleanup = "zap";
    };
    casks = [
      "cleanshot"
      "markedit"
    ];
  };
}
