# dotfiles

macOS system configuration using [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager), managed as a single Nix flake.

## What's included

**System (host/):**
- CLI tools via Nix: coreutils, ripgrep, ag, wget, nmap, jq, htop, awscli, heroku, etc.
- GUI apps via Homebrew: CleanShot
- macOS defaults: auto-hide dock, fast key repeat, disable auto-correct, Touch ID for sudo, 24h clock, etc.

**User (home/):**
- **Zsh** with autosuggestions, syntax highlighting, history substring search
- **Starship** prompt (minimal Pure-like theme)
- **Git** with SSH commit signing, aliases, global gitignore
- **Vim** with molokai, fugitive, ctrlp, airline, language plugins
- **Ghostty** terminal config
- **Shell tools:** direnv, atuin, fzf, bat, eza

## From-scratch setup

### 1. Install Nix

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
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

### 4. Restart your shell

Open a new terminal session. Everything should be ready.

## Day-to-day usage

After making changes to any `.nix` file:

```sh
rebuild-nix
```

This is an alias for `sudo darwin-rebuild switch --flake ~/Source/dotfiles`.

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
    ├── shell.nix             # Zsh, starship, direnv, atuin, fzf, bat, eza
    └── apps/
        ├── git.nix           # Git config, aliases, SSH signing
        ├── vim.nix           # Vim plugins & settings
        └── ghostty.nix       # Ghostty terminal config
```

**Design principle:** Nix manages CLI tools and system config. Homebrew is reserved for macOS GUI apps that Nix can't handle. Everything is declarative and reproducible.
