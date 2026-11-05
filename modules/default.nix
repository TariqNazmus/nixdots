{ lib, ... }:

let
  # Read directory contents and types ("regular" or "directory")
  entries = builtins.readDir ./.;

  # Filter for directories OR .nix files (skip self and nvidia)
  validEntries = lib.filterAttrs (
    name: type:
    (type == "directory" && name != "nvidia")
    || (type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix" && name != "nvidia.nix")
  ) entries;
in
{
  # Map valid entries to full paths
  imports = lib.mapAttrsToList (name: _: ./. + "/${name}") validEntries;
}
