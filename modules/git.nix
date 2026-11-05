{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull; # Includes libsecret for GNOME Keyring integration
    lfs.enable = true;

    # Declarative /etc/gitconfig settings
    config = {
      user = {
        name = "Sadat";
        email = "your-email@example.com"; # Replace with your GitHub/GitLab email
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
