{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull; # Includes libsecret for GNOME Keyring integration
    lfs.enable = true;

    # Declarative /etc/gitconfig settings
    config = {
      user = {
        name = "TariqNazmus";
        email = "tariq.nazmus@gmail.com";
      };

      init.defaultBranch = "main";
      push.autoSetupRemote = true; # Automatically sets upstream on first 'git push'
      pull.rebase = true;
      credential.helper = "libsecret";
    };
  };

  environment.systemPackages = with pkgs; [
    gh      # GitHub CLI for browser authentication and repo creation
    lazygit # Fast terminal UI for Git
  ];
}
