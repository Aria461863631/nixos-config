{ config, lib, pkgs, ... }:

let

in {
  home.packages = with pkgs.python39Packages; [
    ipython
    pipx
    yapf
    isort
  ];
}
