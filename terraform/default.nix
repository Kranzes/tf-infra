{ inputs, ... }:

{
  perSystem = { system, ... }: {
    packages.terraformConfiguration = inputs.terranix.lib.terranixConfiguration {
      inherit system;
      modules = [
        ./hcloud.nix
      ];
    };
  };
}
