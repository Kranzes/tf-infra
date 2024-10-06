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
    tailnet = "ilanjoselevich.com";
  };

  resource."tailscale_acl"."ilanjoselevich-com-ts-acl" = {
    acl = builtins.toJSON {
      acls = [
        # All members can access their own devices
        {
          action = "accept";
          src = [ "autogroup:members" ];
          dst = [ "autogroup:self:*" ];
        }
        # All users of group "admin" and devices tagged as "infra" can access devices tagged tag:infra, and the internet through an exit node
        {
          action = "accept";
          src = [ "tag:infra" "autogroup:admin" ];
          dst = [ "tag:infra:*" "autogroup:internet:*" ];
        }
        # Users of group "admin" can access everything
        {
          action = "accept";
          src = [ "autogroup:admin" ];
          dst = [ "*:*" ];
        }
      ];
      # Users of group "admin" can apply the tag tag:infra
      tagOwners."tag:infra" = [ "autogroup:admin" ];

      # Exit nodes from a user of group "admin" or a node in tag:infra will be approved automatically
      autoApprovers.exitNode = [ "autogroup:admin" "tag:infra" ];
    };
  };
}
