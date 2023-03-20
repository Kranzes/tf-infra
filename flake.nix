{
  inputs = {
    flake-parts = { url = "github:hercules-ci/flake-parts"; inputs.nixpkgs-lib.follows = "nixpkgs"; };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    terranix = { url = "github:terranix/terranix"; inputs.nixpkgs.follows = "nixpkgs"; };
    treefmt-nix.url = "github:numtide/treefmt-nix";
    hercules-ci-effects = { url = "github:hercules-ci/hercules-ci-effects"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        ./terraform
        ./nix/development.nix
        ./nix/deployment.nix
        inputs.hercules-ci-effects.flakeModule
      ];
    };
}
