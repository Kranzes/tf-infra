{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShellNoCC {
      packages = [
        pkgs.rage
        pkgs.age-plugin-yubikey
      ];
    };
  };
}
