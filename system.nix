{ config, pkgs, ... }: {
  system = {
    defaults = {
      dock = {
        autohide = true;
        show-recents = false;
      };

      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = false;
      remapCapsLockToControl = true;
    };
  };

  time.timeZone = "Asia/Tokyo";

  # Fonts
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome
      nerdfonts
    ];
  };

  users.users.doongle = {
    name = "doongle";
    home = "/Users/doongle";
  };

  nix.settings.trusted-users = [ "doongle" ];

  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  environment.variables = {
    EDITOR = "vim";
    LANG = "ko_KR.UTF-8";
  };
  environment.shellAliases = {
    ll = "ls -lhF";
    la = "ls -alhF";
  };
}
