{
  description = "NixOS config";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.05";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      # Available through 'nixos-rebuild --flake .#daniel-server'
      nixosConfigurations = {
        daniel-server = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/daniel-server/configuration.nix ];
        };
      };

      # Available through 'home-manager --flake .#danieldbird@daniel-server'
      homeConfigurations = {
        "danieldbird@daniel-server" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/danieldbird/daniel-server/home.nix ];
        };
      };
    };
}
