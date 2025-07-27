{
  imports = [ ];

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
      nixrebuild = "sudo nixos-rebuild switch --flake ~/nixconfig#daniel-server";
      homerebuild = "home-manager switch --flake ~/nixconfig#danieldbird@daniel-server";
      rebuild = "nixrebuild && homerebuild";
      nixgens = "sudo nixos-rebuild list-generations";
      homegens = "home-manager generations";
      nixclean = "sudo nix-env --delete-generations +5 --profile /nix/var/nix/profiles/system && nix-collect-garbage -d";
      homeclean = "nix-env --delete-generations +5 --profile ~/.local/state/nix/profiles/home-manager";
      cleanup = "nixclean && homeclean";
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

  home.stateVersion = "25.05";
}
