{ inputs, ... }:

{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = { pkgs, lib, config, ... }: {
    packages = {
      terraform-with-plugins = (pkgs.terraform.withPlugins (p: with p; [ hcloud ])) // { meta.mainProgram = "terraform"; };

      custom-rage = (pkgs.writeShellApplication {
        name = "rage";
        runtimeInputs = with pkgs; [ rage age-plugin-yubikey ];
        text = ''
          args=(-i ${inputs.self}/secrets/identities/kranzes-yk5.txt)
          if [[ " $* " == *" -d "* ]];
          then
            rage "''${args[@]}" "$@"
          else
            rage "''${args[@]}" -R "${inputs.self}/secrets/recipients.txt" "$@"
          fi
        '';
      }) // { inherit (pkgs.rage) meta; };
    };


    devShells.default = pkgs.mkShellNoCC rec {
      name = "terraform";
      packages = [
        config.packages.terraform-with-plugins
        config.packages.custom-rage
        pkgs.hci
      ];
      shellHook = ''
        echo -e "\n\033[1;36m❄️ Welcome to the '${name}' devshell ❄️\033[0m\n"
        echo -e "\033[1;33m[Packages]\n\033[0m"
        echo -e "${lib.concatMapStringsSep "\n" (p: "  ${lib.getName p} \t- ${p.meta.description or ""}") packages}" | ${lib.getExe pkgs.unixtools.column} -ts $'\t'
        echo
      '';
    };

    treefmt = {
      projectRootFile = "flake.nix";
      programs.nixpkgs-fmt.enable = true;
    };
  };
}
