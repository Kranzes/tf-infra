{
  terraform.required_providers.cloudflare.source = "cloudflare/cloudflare";

  variable."cloudflare_api_token" = {
    description = "Cloudflare API token";
    type = "string";
    sensitive = true;
  };

  provider."cloudflare".api_token = "$\{var.cloudflare_api_token}";

  imports = [
    ./ilanjoselevich.com.nix
  ];
}
