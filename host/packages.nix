{ pkgs, ... }:

{
  # All CLI packages in one place.
  # GUI apps go in homebrew.nix instead.
  environment.systemPackages = with pkgs; [
    # GNU core utilities (replacing outdated macOS versions)
    coreutils
    moreutils
    findutils
    gnused
    gnugrep
    gawk

    # Networking & security tools
    nmap
    wget

    # Search tools
    silver-searcher
    ripgrep

    # Directory tools
    tree

    # Terminal
    ghostty-bin

    # Development tools
    jq
    htop

    # Cloud tools
    heroku
    awscli2

    # File association management
    duti

  ];
}
