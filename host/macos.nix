{ pkgs, ... }:

{
  # Default app associations (applied on rebuild)
  system.activationScripts.postActivation.text = ''
    # .md files → MarkEdit (duti is per-user, so run as the console user)
    sudo -u djm ${pkgs.duti}/bin/duti -s app.cyan.markedit .md all
  '';

  # macOS system preferences managed by nix-darwin.
  # These are applied on `darwin-rebuild switch`.
  system.defaults = {

    # Global preferences
    NSGlobalDomain = {
      # Show file extensions in Finder
      AppleShowAllExtensions = true;
      # Automatically switch between dark and light mode
      AppleInterfaceStyleSwitchesAutomatically = true;
      # Keyboard: faster repeat rate (defaults are 25/6)
      InitialKeyRepeat = 10;
      KeyRepeat = 1;

      # Disable auto-correct annoyances
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;

      # Enable trackpad force click
      "com.apple.trackpad.forceClick" = true;
    };

    # Dock
    dock = {
      # Auto-hide the Dock
      autohide = true;
      # Don't show recent apps in the Dock
      show-recents = false;
      # Icon size in pixels
      tilesize = 48;
      # Magnify icons on hover
      magnification = true;
      # Magnified icon size in pixels
      largesize = 70;
      # Bottom-right hot corner: Lock Screen (13)
      wvous-br-corner = 13;
    };

    # Finder
    finder = {
      # Show all file extensions
      AppleShowAllExtensions = true;
      # Don't warn when changing file extensions
      FXEnableExtensionChangeWarning = false;
      # Show external drives on desktop
      ShowExternalHardDrivesOnDesktop = true;
      # Hide internal drives on desktop
      ShowHardDrivesOnDesktop = false;
      # Show removable media on desktop
      ShowRemovableMediaOnDesktop = true;
    };

    # Menu bar clock
    menuExtraClock = {
      # Use 24-hour clock
      Show24Hour = true;
      # Show day of week
      ShowDayOfWeek = true;
      # Show date
      ShowDate = 1;
    };

    # Screenshots (defaults are fine, but here for future tweaks)
    # screencapture = {
    #   location = "~/Desktop";
    #   type = "png";
    # };
  };
}
