# It was generated by `nixos-generate-config`.
{ config, lib, pkgs, modulesPath, ... }:

let
  nixos-hardware = builtins.fetchGit {
    url = "https://github.com/NixOS/nixos-hardware";
    rev = "429f232fe1dc398c5afea19a51aad6931ee0fb89";
  };

in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    "${nixos-hardware}/common/pc/laptop"
    "${nixos-hardware}/common/pc/laptop/ssd"
    "${nixos-hardware}/common/cpu/intel/cpu-only.nix"
    "${nixos-hardware}/common/gpu/intel"
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.blacklistedKernelModules = [ "bluetooth" "btusb" ];

  services.xserver.videoDrivers = [ "intel" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/751482e7-69a9-4bf5-8251-ee32657c789a";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/772D-67D0";
    fsType = "vfat";
  };

  fileSystems."/media/ubuntu" = {
    device = "/dev/disk/by-uuid/8eb1aec6-4a38-47ae-aeb2-8e73cd4c9078";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/2638ce59-c2b9-4178-a2da-c3d02d3b3d78"; }
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
