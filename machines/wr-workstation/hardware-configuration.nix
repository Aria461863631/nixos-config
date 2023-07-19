# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

let
  nixos-hardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware";
    rev = "429f232fe1dc398c5afea19a51aad6931ee0fb89";
  };

in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    "${nixos-hardware}/common/pc/ssd"
    "${nixos-hardware}/common/cpu/amd"
    "${nixos-hardware}/common/gpu/nvidia"
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  services.xserver.dpi = 96;

  environment.variables = {
    LIBVA_DRIVER_NAME = "vdpau";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS-ROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXOS-BOOT";
    fsType = "vfat";
  };

  fileSystems."/media/ubuntu" = {
    device = "/dev/disk/by-label/UBUNTU";
    fsType = "ext4";
  };

  fileSystems."/media/data" = {
    device = "/dev/disk/by-label/DATA";
    fsType = "ext4";
  };
}
