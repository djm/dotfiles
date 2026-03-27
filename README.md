
            djm's dotfiles                           (c) github.com/djm


            macOS :..... PLATFORM .... PROTECTION ........: nix flake
              zsh :..... SHELL ....... DISC(S) ...........: 0
          ghostty :..... TERMINAL .... GAME.TYPE .........: dotfiles
              lix :..... SUPPLIER .... WRITTEN.BY ........: djm

```

# dotfiles

macOS system configuration using [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager), managed as a single Nix flake.

## Structure

```
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
        └── maestral.nix      # Dropbox sync (~/Synced dir + config)
```

Nix manages CLI tools and system config. Homebrew is reserved for macOS GUI apps that Nix can't handle. Everything is declarative and reproducible.

## From-scratch setup

### 1. Install Nix via Lix

[Lix](https://lix.systems/) is a community fork of the Nix package manager focused on correctness and usability. This installs the Nix engine and CLI tooling needed to evaluate flakes and build the system configuration.

```sh
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
```

### 2. Clone this repo

```sh
git clone https://github.com/djm/dotfiles.git ~/Source/dotfiles
```

### 3. Build and apply

```sh
sudo darwin-rebuild switch --flake ~/Source/dotfiles
```

This will install all packages, configure macOS defaults, set up zsh, and symlink all dotfiles.

### 4. Switch to Ghostty

Close the current terminal and open [Ghostty](https://ghostty.org/). It was installed in step 3 and is the configured terminal from here on.

## Post-install setup

These services require one-time configuration after a fresh install.

### Atuin (shell history sync)

```sh
atuin login
```

When prompted for the encryption key, retrieve it from 1Password. Then pull down history:

```sh
atuin sync
```

### Maestral (Dropbox sync)

Open **Maestral.app** from Applications. It will walk you through linking your Dropbox account and choosing which folders to sync.

## Day-to-day usage

After making changes to any `.nix` file:

```sh
rebuild-nix
```

This is an alias for `sudo darwin-rebuild switch --flake ~/Source/dotfiles`.
