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
      commit = {
        template = "~/.gitcommit_template";
      };
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = false;
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
    direnv
    graphviz
    ripgrep
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
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    initExtra = ''
	            export PATH=/opt/homebrew/bin:$PATH
    '';
  };

  home.file.".config/aerospace/eowc.sh" = {
    source = ./bin/aerospace-window-changed.sh;
    executable = true;
  };
  home.file.".config/ghostty/config".source = ./config/ghostty;
  home.file.".gitcommit_template".source = ./config/git-commit-template;
  home.file.".bashrc".text = ''
    export POWERLINE_GO_PATH=${POWERLINE_GO_PATH}
    function _update_ps1() {
      PS1="$($POWERLINE_GO_PATH/powerline-go -error $? -jobs $(jobs -p | wc -l))"
    }

    if [ "$TERM" != "linux" ] && [ -f "$POWERLINE_GO_PATH/powerline-go" ]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
  '';
}
