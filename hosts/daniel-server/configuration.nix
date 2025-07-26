{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  networking.hostName = "daniel-server";
  networking.networkmanager.enable = true;

  services.samba = {
    enable = true;
    openFirewall = true;
    shares = {
      home = {
        path = "/home/danieldbird";
        browseable = true;
        readOnly = false;
        validUsers = [ "danieldbird" ];
        createMask = "0700";
        directoryMask = "0700";
        vetoFiles = [
          ".DS_Store"
          "._*"
        ];
        vetoFilesOp = "delete";
      };

      root = {
        path = "/";
        browseable = true;
        readOnly = false;
        validUsers = [
          "danieldbird"
        ];
        createMask = "0700";
        directoryMask = "0700";
        vetoFiles = [
          ".DS_Store"
          "._*"
        ];
        vetoFilesOp = "delete";
      };
    };
  };

  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.danieldbird = {
    isNormalUser = true;
    description = "Daniel Bird";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [ ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "25.05";
}
