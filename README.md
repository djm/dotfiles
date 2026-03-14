```


                         ▄▓▓▓▄          ▄▓▓▓▄
                        ▐█████▌        ▐█████▌
                     ▄▄▄ ▀███▀ ▄▓████▄▄ ▀███▀ ▄▄▄
                    █████▄▄▄▄▄█████████████▄▄▄█████
                    ▀██████████████████████████████▀
                      ▀████████████████████████████
                    ▄▄▄████████████████████████▄▄▄
                    █████▀▀▀▀▀█████████████▀▀▀▀▀█████
                    ▀▀▀ ▄███▄ ▀▓████████▓▀ ▄███▄ ▀▀▀
                       ▐█████▌  ▀▓████▓▀  ▐█████▌
                        ▀███▀     ▀██▀     ▀███▀


              ▄▀▀▄  ░▄  ▄▀▄▀▄  ▀█  ▄▀▀   ▄▀▀▄  ░▄  ▄▀▄  ▄▀▀  ▄▀▀
              █  ▓  █ █ █   ▓   █  ▓▀ ▄   █  ▓  █ █ █▀▀  ▓▀ ▄ ▀▀▀█
              ▀▀▀  ▀▀▀▀ ▀   ▀   ▀  ▀▀▀▀   ▀▀▀  ▀▀▀▀ ▀    ▀▀▀▀ ▀▀▀


             djm's dotfiles                        (c) github.com/djm


             macOS :..... PLATFORM ... MANAGER .......: nix-darwin
              flake :..... FORMAT ..... SHELL ..........: zsh
        home-manager :..... HOME ....... TERMINAL .......: ghostty
               lix :..... PKG.MGR ... TYPE ...........: declarative


                    ▄▀▀  ▓▄▄  ▄▀▀█ ▓  ▄ ▄▀▀  ▓▄▄  ▓  ▄ ▄▀▀█ ▄▀▀
  ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ ▀▀▀█ █  ▄ █▀▓  █  ▓ █    █  ▄ █  ▓ █▀▓  ▓▀ ▄ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
                      ▀▀  ▀▀▀  █   ▀▀▀▀ ▀▀▀  ▀▀▀  ▀▀▀▀  █   ▀▀▀▀

  .
  ├── flake.nix                 # Flake inputs & system definition
  ├── flake.lock
  ├── host/
  │   ├── configuration.nix     # System-level config (nix settings, shell, Touch ID)
  │   ├── packages.nix          # CLI packages (installed via Nix)
  │   ├── homebrew.nix          # GUI apps (installed via Homebrew)
  │   └── macos.nix             # macOS system defaults
  └── home/
      ├── default.nix           # Home-manager entry point (PATH, misc dotfiles)
      ├── shell.nix             # Zsh, starship, direnv, fzf, bat, eza
      └── apps/
          ├── atuin.nix         # Shell history sync
          ├── git.nix           # Git config, aliases, SSH signing
          ├── vim.nix           # Vim plugins & settings
          ├── ghostty.nix       # Ghostty terminal config
          └── maestral.nix      # Dropbox sync (maestral + launchd agent)

  Nix manages CLI tools and system config. Homebrew is reserved for
  macOS GUI apps that Nix can't handle. Everything is declarative
  and reproducible.


              ▄▀▀  ▄▀▀▄ ▓▄▄  ▄▀▀  ▓▄▄  ▄▀▀█  ▄▀▀▄  ▓  ▄  ▄▀▀
  ▀▀▀▀▀▀▀▀▀▀▀ ▀▀▀█ ▓▀   █  ▄ ▓▀ ▄ █  ▄ █▀▓   █  ▓  █  ▓  ▀▀▀█ ▀▀▀▀▀▀▀▀▀▀▀▀
               ▀▀  ▀▀▀▀ ▀▀▀  ▀▀▀▀ ▀▀▀   █    ▀▀▀   ▀▀▀▀  ▀▀▀

  1. Install Nix via Lix (community fork focused on correctness):

     curl -sSf -L https://install.lix.systems/lix | sh -s -- install

  2. Clone this repo:

     git clone https://github.com/djm/dotfiles.git ~/Source/dotfiles

  3. Build and apply:

     sudo darwin-rebuild switch --flake ~/Source/dotfiles

     This installs all packages, configures macOS defaults, sets up
     zsh, and symlinks all dotfiles.

  4. Close the current terminal and open Ghostty. It was installed in
     step 3 and is the configured terminal from here on.


         ▄▀▀▄  ▄▀▀▄  ▄▀▀   ▓▄▄    ▀ ▄▀▀▄  ▄▀▀   ▓▄▄  ▄▀▀▄ ▓   ▓
  ▀▀▀▀▀▀ █▀▀▓  █  ▓  ▀▀▀█  █  ▄   █ █  ▓  ▀▀▀█  █  ▄ █▀▀▓ █   █ ▀▀▀▀▀▀▀▀▀▀
         ▀     ▀▀▀   ▀▀▀   ▀▀▀    ▀ ▀     ▀▀▀   ▀▀▀  ▀    ▀▀▀ ▀▀▀

  These services require one-time configuration after a fresh install.

  Atuin (shell history sync):

     atuin login

     When prompted for the encryption key, retrieve it from 1Password.
     Then pull down history:

     atuin sync

  Maestral (Dropbox sync):

     maestral setup

     This will walk you through linking your Dropbox account and
     choosing which folders to sync.


                 ▄▀▀▄  ▄▀▀▄ ▀▀█▀▀ ▓   ▀▀█▀▀  ▓  ▄  ▄▀▀   ▄▀▀
  ▀▀▀▀▀▀▀▀▀▀▀▀▀ █  ▓  █▀▀▓   █   █     █    █  ▓  ▓▀ ▄  ▀▀▀█ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀
                 ▀▀▀   ▀    ▀▀▀▀▀ ▀▀▀   ▀    ▀▀▀▀  ▀▀▀▀  ▀▀▀

  After making changes to any .nix file:

     rebuild-nix

  This is an alias for:

     sudo darwin-rebuild switch --flake ~/Source/dotfiles


```
