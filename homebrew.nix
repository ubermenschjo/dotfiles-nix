{ pkgs, ... }: {
  homebrew = {
    enable = true;

    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    onActivation.cleanup = "zap";

    brews = [ 
    "mas"
    ];

    masApps = {
    "Xcode" = 497799835;
    "KakaoTalk" = 869223134;
    "LINE" = 539883307;
    "Microsoft Remote Desktop" = 1295203466;
    };

    casks = [
	    "emacs"
      "firefox"
      "alacritty"
      "docker"
      "cursor"
      "slack"
      "spotify"
      "microsoft-teams"
      "discord"
    ];
  };
}
