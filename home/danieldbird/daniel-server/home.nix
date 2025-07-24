{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [ ];

  home.stateVersion = "25.05";
  home = {
    username = "danieldbird";
    homeDirectory = "/home/danieldbird";
  };

  nixpkgs = {
    config = {
      allowUnfree = false;
    };
  };

  programs.home-manager = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Daniel Bird";
    userEmail = "danieldbird@gmail.com";
    extraConfig.init.defaultBranch = "main";
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      c = "clear";
      reload = "source ~/.zshrc";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      line_break = {
        disabled = true;
      };
      git_branch = {
        symbol = "☊ ";
      };
      nodejs = {
        symbol = "📦";
      };
      package = {
        disabled = true;
      };
    };
  };

  systemd.user.startServices = "sd-switch";
}
