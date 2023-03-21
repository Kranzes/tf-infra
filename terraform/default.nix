{ inputs, ... }:

{
  perSystem = { pkgs, ... }: {
    packages.terraformConfiguration = inputs.terranix.lib.terranixConfiguration {
      inherit pkgs;
      modules = [
        ./hcloud.nix
        ./cloudflare.nix
      ];
    };
  };
}
