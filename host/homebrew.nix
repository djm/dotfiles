{ ... }:

{
  # Homebrew is used ONLY for macOS GUI apps (casks) that Nix can't install.
  # All CLI tools should go in darwin.nix or home.nix instead.
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # Uninstall anything installed via brew that isn't listed in this file
      cleanup = "zap";
    };
    taps = [
      "homebrew/cask"
      "macos-fuse-t/cask"
    ];
    casks = [
      "alt-tab"
      "claude"
      "cleanshot"
      "codex"
      "cryptomator"
      "fuse-t" # For Cryptomator
      "maestral"
      "markedit"
      "tableplus"
      "vlc"
    ];
  };
}
