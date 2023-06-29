{ inputs, ... }:

{
  perSystem = { pkgs, config, ... }: {
    packages = {
      terraform-with-plugins = (pkgs.terraform.withPlugins (p: with p; [
        cloudflare
        tailscale
      ])) // { meta.mainProgram = "terraform"; };

      terraformConfiguration = pkgs.runCommand "config.tf.json"
        {
          terranixConfiguration = inputs.terranix.lib.terranixConfiguration {
            inherit pkgs;
            modules = [
              ./cloudflare
              ./tailscale.nix
            ];
          };
          nativeBuildInputs = [ config.packages.terraform-with-plugins ];
        } ''
        mkdir "$out"
        ln -s "$terranixConfiguration" "$out/config.tf.json"
        terraform -chdir="$out" init -backend=false -compact-warnings
        terraform -chdir="$out" validate -compact-warnings
        rm -rf .terraform
      '';
    };
  };
}
