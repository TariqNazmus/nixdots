{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sadat = {
    isNormalUser = true;
    description = "sadat";
    extraGroups = [ "networkmanager" "input" "wheel" "video" "audio" "tss" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      brave
    ];
  };

  # Change runtime directory size
  #services.logind.settings.Login = {
  #  RuntimeDirectorySize="8G";
  #};
}