{ pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;

    # History
    history = {
      size = 100000;
      save = 100000;
      ignoreDups = true;
      ignoreAllDups = true;
      share = true;
    };

    # Completion settings
    completionInit = ''
      autoload -Uz compinit
      compinit
    '';

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # Performance profiling (uncomment to debug slow startup)
        # zmodload zsh/zprof
      '')
      ''
        # Case-insensitive completion
        zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

        # zsh-history-substring-search configuration
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

        # Enable Erlang/Elixir shell history
        export ERL_AFLAGS="-kernel shell_history enabled"
      ''
    ];

    # Plugins managed by home-manager (replaces zplug)
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.zsh-history-substring-search;
        file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
      }
    ];

    # Shell aliases
    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      # AI
      c = "claude --dangerously-skip-permissions";
      cdx = "codex --yolo";

      # Python
      clearpyc = "find . -name '*.pyc' -exec rm -rf {} \\;";
      serve = "python3 -m http.server";
      jsonify = "python3 -m json.tool";

      # Docker
      dc = "docker-compose";
      dx = "docker exec -it";
      dc-dev = "docker-compose -f docker-compose-dev.yml";
      dc-prod = "docker-compose -f docker-compose-prod.yml";

      # Git
      gb = "git blame";
      gc = "git commit";
      gco = "git checkout";
      gd = "git diff";
      gm = "git merge";
      gp = "git push";
      gr = "git rebase";
      gs = "git status";
      gref = "git reflog";
      gshow = "git show";

      # Elixir
      mc = "mix compile";
      mdg = "mix deps.get";

      # ls (using eza)
      l = "eza -lF";
      la = "eza -laF";
      lsd = "eza -lD";
      ls = "eza";

      # grep
      grep = "grep --color=auto";

      # macOS
      flushdns = "dscacheutil -flushcache && killall -HUP mDNSResponder";
      show = "defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder";
      hide = "defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder";

      # NFO file viewer - converts CP437 (DOS) encoding to UTF-8 so
      # block/box-drawing characters render correctly in modern terminals.
      nfo = "iconv -f CP437 -t UTF-8";

      # Misc
      path = "echo -e \${PATH//:/\\\\n}";

      # Nix
      dotfiles-apply = "sudo darwin-rebuild switch --flake ~/Source/dotfiles";
      dotfiles-update = "nix flake update brew-src homebrew-core homebrew-cask macos-fuse-t-homebrew-cask --flake ~/Source/dotfiles && sudo darwin-rebuild switch --flake ~/Source/dotfiles";
    };

    # Environment variables
    sessionVariables = {
      EDITOR = "vim";
      LC_CTYPE = "en_GB.UTF-8";
      LC_ALL = "en_GB.UTF-8";
      LANG = "en_GB.UTF-8";
      CLICOLOR = "1";
      MANPAGER = "less -X";
      NODE_REPL_HISTORY_SIZE = "32768";
      NODE_REPL_MODE = "sloppy";
      LSCOLORS = "BxBxhxDxfxhxhxhxhxcxcx";
    };
  };

  # Pure prompt (replaces the zplug-managed pure theme)
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # Minimal prompt similar to Pure
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
      directory = {
        style = "blue bold";
      };
      git_branch = {
        style = "gray";
        format = "[$branch]($style) ";
      };
      git_status = {
        style = "red";
      };
      cmd_duration = {
        min_time = 5000;
        style = "yellow";
      };
    };
  };

  # Readline / inputrc
  programs.readline = {
    enable = true;
    extraConfig = ''
      set completion-ignore-case on
      set show-all-if-ambiguous on
      set mark-symlinked-directories on
      set match-hidden-files off
      set page-completions off
      set completion-query-items 200
      set visible-stats on
      set skip-completed-text on
      set input-meta on
      set output-meta on
      set convert-meta off

      "\e[A": history-search-backward
      "\e[B": history-search-forward
      "\e[C": forward-char
      "\e[D": backward-char
      "\e[3;3~": kill-word
    '';
  };

  # Shell-integrated tools

  # Direnv - auto-load .envrc files
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true; # Better nix integration with direnv
    config = {
      global = {
        # Suppress noisy direnv output
        log_format = "";
        hide_env_diff = true;
      };
    };
  };

  # fzf - fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # bat - better cat
  programs.bat = {
    enable = true;
  };

  # eza - modern ls replacement
  programs.eza = {
    enable = true;
  };
}
