{ lib, ... }:

{
  imports = [
    ./shell.nix
    ./apps/git.nix
    ./apps/ghostty.nix
    ./apps/vim.nix
    ./apps/atuin.nix
    ./apps/maestral.nix
  ];

  home.username = "djm";
  home.homeDirectory = lib.mkForce "/Users/djm";
  home.stateVersion = "24.11";

  # Add common bin directories to PATH
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
  ];

  # Suppress the "Last login" message in terminal
  home.file.".hushlogin".text = "";

  # Flake8 config
  xdg.configFile."flake8".text = ''
    [flake8]
    ignore = E126,E128,E123
    max-line-length = 100
  '';

  # Git commit message template
  home.file.".git_commit_msg.txt".text = ''
    # If applied, this commit will...

    # Why is this change is being made?

  '';

  programs.home-manager.enable = true;
}
