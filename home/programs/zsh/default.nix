{ config, lib, pkgs, ... }:

let

in {
  home.sessionVariables = {
    # Do the initialization when the script is sourced.
    ZVM_INIT_MODE = "sourcing";
    # Use case-sensitive completion.
    CASE_SENSITIVE = "true";
    # To allow zsh load completion files under /nix/store.
    ZSH_DISABLE_COMPFIX = "true";
    # Let CMake automatically generates Compilation Databases.
    CMAKE_EXPORT_COMPILE_COMMANDS = "ON";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "extract" "sudo" "colored-man-pages" "history-substring-search"
      ];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    initExtra= ''
      # Use Up/Down arrow keys to search substring in history.
      zvm_bindkey viins "^[[A" history-substring-search-up
      zvm_bindkey viins "^[[B" history-substring-search-down
      # Fix Home/End keys in zsh-vi-mode.
      zvm_bindkey viins "^[[H" beginning-of-line
      zvm_bindkey viins  "^[[F" end-of-line
      zvm_bindkey vicmd "^[[H" beginning-of-line
      zvm_bindkey vicmd "^[[F" end-of-line
      zvm_bindkey visual "^[[H" beginning-of-line
      zvm_bindkey visual "^[[F" end-of-line
    '';
    shellAliases = {
      # Vim
      v = "vim";
      gv = "gvim";
      # VCS
      origin = "git fetch origin $(current_branch) && git reset --hard origin/$(current_branch)";
      lg = "lazygit";
      ap = "arc patch --nobranch";
      ac = "arc diff HEAD~ --create";
      au = "arc diff HEAD~ --update";
      al = "arc land";
    };
  };
}
