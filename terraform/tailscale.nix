{ lib, ... }:

{
  terraform.required_providers.tailscale.source = "tailscale/tailscale";

  variable."tailscale_token" = {
    description = "Tailscale API token";
    type = "string";
    sensitive = true;
  };

  provider."tailscale" = {
    api_key = lib.tfRef "var.tailscale_token";
    tailnet = "kranzes.github";
  };

  resource."tailscale_acl"."kranzes-github-ts-acl" = {
    acl = builtins.toJSON {
      groups."group:admin" = [ "kranzes@github" ];

      acls = [
        # All members can access their own devices
        {
          action = "accept";
          src = [ "autogroup:members" ];
          dst = [ "autogroup:self:*" ];
        }
        # All users of group "admin" and devices tagged as "infra" can access devices tagged tag:infra
        {
          action = "accept";
          src = [ "tag:infra" "group:admin" ];
          dst = [ "tag:infra:*" ];
        }
        # Users of group "admin" can access everything
        {
          action = "accept";
          src = [ "group:admin" ];
          dst = [ "*:*" ];
        }
      ];
      # Users in group:infra can apply the tag tag:infra
      tagOwners."tag:infra" = [ "group:admin" ];
    };
  };
}
