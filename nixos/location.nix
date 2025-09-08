{ pkgs, ... }:

{
  # services.geoclue2.appConfig = {
  #     "gammastep" = {
  #       isAllowed = true;
  #       isSystem = false;
  #       users = [ "1000" ];
  #     };
  # };

  location.provider = "geoclue2";
  services.geoclue2.enable = true;
}
