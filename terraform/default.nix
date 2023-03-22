{ inputs, ... }:

{
  perSystem = { pkgs, ... }: {
    packages = {
      terraform-with-plugins = (pkgs.terraform.withPlugins (p: with p; [
        hcloud
        cloudflare
        tailscale
      ])) // { meta.mainProgram = "terraform"; };

      terraformConfiguration = inputs.terranix.lib.terranixConfiguration {
        inherit pkgs;
        modules = [
          ./hcloud.nix
          ./cloudflare
          ./tailscale.nix
        ];
      };
    };
  };
}
