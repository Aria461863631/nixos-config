{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # light-locker is a simple locker (forked from gnome-screensaver) that aims to have simple, sane, secure defaults
    # and be well integrated with the desktop while not carrying any desktop-specific dependencies.
    # It relies on lightdm for locking and unlocking your session via UPower or logind/systemd.
    # By default, it will lock on lid-closed, screensaver-deactivated (screen blank) and sleep.
    # To work with xfce4, the default xflock4 should fail to run (none of xscreensaver, gnome-screensaver, xlockmore and slock was installed).
    lightlocker
  ];

  environment.sessionVariables = with pkgs; {
    # Export the gsettings-schemas of light-locker, so that xfce4-power-manager-settings can config light-locker.
    XDG_DATA_DIRS = [ "${lightlocker}/share/gsettings-schemas/${lightlocker.name}" ];
  };
}
