{ ... }:

{
  # Ghostty terminal config
  # Full reference: https://ghostty.org/docs/config/reference
  xdg.configFile."ghostty/config".text = ''
    # Padding inside terminal cells (in points)
    window-padding-x = 10
    window-padding-y = 4
    window-padding-balance = true
  '';
}
