{ ... }:

{
  # Atuin - better shell history with sync
  # Run `atuin login` and `atuin sync` on first use.
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      dialect = "uk";
      auto_sync = true;
      sync_frequency = "10m";
      enter_accept = false;
      search_mode = "fuzzy";
      sync = {
        records = true;
      };
    };
  };
}
