{ pkgs, ... }:

{
  # Maestral - open-source Dropbox client
  # Run `maestral setup` on first use to link your Dropbox account.
  launchd.agents.maestral = {
    enable = true;
    config = {
      Label = "com.maestral.daemon";
      ProgramArguments = [ "${pkgs.maestral}/bin/maestral" "start" "--foreground" ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/tmp/maestral.log";
      StandardErrorPath = "/tmp/maestral.err";
    };
  };
}
