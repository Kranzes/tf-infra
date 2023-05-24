{ lib, ... }:

{
  terraform.required_providers.cloudflare.source = "cloudflare/cloudflare";

  variable."cloudflare_api_token" = {
    description = "Cloudflare API token";
    type = "string";
    sensitive = true;
  };

  provider."cloudflare".api_token = lib.tfRef "var.cloudflare_api_token";

  imports = [
    ./ilanjoselevich.com.nix
    ./israel.nix.ug.nix
    ./yaelcohen.net.nix
  ];
}
