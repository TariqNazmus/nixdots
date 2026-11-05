# modules/tool-nh.nix
{ pkgs, ... }:

{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = "/home/sadat/nixdots";
  };
environment.sessionVariables = {
    NH_FLAKE = "/home/sadat/nixdots";
    NH_OS_FLAKE = "/home/sadat/nixdots";
  };
}
