{ config, lib, ... }:

let
  syncPath = "${config.home.homeDirectory}/Synced";
  configDir = "${config.home.homeDirectory}/Library/Application Support/maestral";
  configFile = "${configDir}/maestral.ini";
in
{
  # Ensure ~/Synced exists as the Dropbox sync target
  home.file."Synced/.keep".text = "";

  # Maestral needs a mutable config file (it writes auth state, etc.) so we
  # can't use home.file (read-only symlink). Instead, write the config on
  # every rebuild via an activation script and use `maestral move-dir` to
  # set the sync path (it performs filesystem operations alongside the
  # config change).
  home.activation.maestralConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${configDir}"
    cat > "${configFile}" << 'EOF'
[auth]
account_id = dbid:AACl97vVq03iCGQo80Jz9kZ1NvCxyylw78o
keyring = keyring.backends.macOS.Keyring
token_access_type = offline

[app]
notification_level = 15
log_level = 20
update_notification_interval = 604800
bandwidth_limit_up = 0.0
bandwidth_limit_down = 0.0
max_parallel_uploads = 6
max_parallel_downloads = 6

[sync]
path = ${syncPath}
excluded_items = ["/Non-synced"]
max_cpu_percent = 20.0
keep_history = 604800
upload = True
download = True

[main]
version = 20.0
EOF
  '';
}
