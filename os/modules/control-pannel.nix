{ config, pkgs, inputs, ... }: {
  environment.etc."/etc/profiles/per-user/logan/share/applications/control-pannel.desktop" = {
    mode = "0644";
    text = ''
      [Desktop Entry]
      Actions=new-empty-window
      Exec=codium %F
      Icon=vscodium
      Name=HELLO
      Type=Application
      Version=1
    '';
  };
}