{ config, pkgs, ... }: 
let
  POWERLINE_GO_PATH = "${pkgs.powerline-go}/bin";
in {
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "doongle";
    userEmail = "ubermenschjo@gmail.com";

    includes = [
      {
        # use diffrent email & name for work
        path = "~/work/.gitconfig";
        condition = "gitdir:~/work/";
      }
    ];

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
    };
  };

  programs.powerline-go = {
    enable = true;
    modules = [ 
      "host"
      "ssh" 
      "cwd" 
      "gitlite" 
      "exit" 
    ];
    modulesRight = [ 
      "time"
    ];
  };

  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    neofetch
    # utils
    jq
    k9s
    direnv
    graphviz
    # network
    curl
    dnsutils
    dig
    # misc
    tree
    powerline-go
    # system
    lsof
    # dev
	  podman
	  podman-compose
	  podman-tui
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
	  customPaneNavigationAndResize = true;
	  mouse = true;
    shell = "/bin/zsh";
	  terminal = "xterm-256color";

     plugins = with pkgs.tmuxPlugins; [
       yank
       {
         plugin = dracula;
         extraConfig = ''
           set -g @dracula-plugins "cpu-usage git ram-usage network network-bandwidth ssh-session weather time"
           set -g @dracula-show-battery false
           set -g @dracula-show-powerline true
           set -g @dracula-refresh-rate 10
           set -g @dracula-show-fahrenheit false
         '';
       }
     ];

    extraConfig = ''
    '';
  };
  home.file.".zshrc".text = ''
	  export PATH=/opt/homebrew/bin:$PATH
  '';
  home.file.".bashrc".text = ''
    export POWERLINE_GO_PATH=${POWERLINE_GO_PATH}
    function _update_ps1() {
      PS1="$($POWERLINE_GO_PATH/powerline-go -error $? -jobs $(jobs -p | wc -l))"
    }

    if [ "$TERM" != "linux" ] && [ -f "$POWERLINE_GO_PATH/powerline-go" ]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
  '';
  home.file."nsp.sh".source = ./bin/nsp.sh;
  home.file."nsp.sh".executable = true;
  home.file.".config/alacritty/alacritty.toml".text = ''
	[window]
    option_as_alt = 'OnlyLeft'
	[terminal]
  	shell= "/bin/zsh"
  '';
}
