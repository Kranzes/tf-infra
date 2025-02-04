{ lib, ... }:

{
  terraform.required_providers.hcloud.source = "hetznercloud/hcloud";

  variable."hcloud_token" = {
    description = "Hetzner Cloud API token";
    type = "string";
    sensitive = true;
  };

  provider."hcloud".token = lib.tfRef "var.hcloud_token";

  resource."hcloud_server"."nixos" = {
    name = "nixos";
    server_type = "cx32";
    image = "fedora-41";
    datacenter = "nbg1-dc3";
    public_net = {
      ipv4_enabled = true;
      ipv6_enabled = true;
    };
    firewall_ids = [ (lib.tfRef "hcloud_firewall.firewall.id") ];
    lifecycle.ignore_changes = [ "ssh_keys" ];
    delete_protection = true;
    rebuild_protection = true;
  };

  resource."hcloud_firewall"."firewall" = {
    name = "firewall";
    rule = lib.mapAttrsToList
      (port: protocol: {
        direction = "in";
        inherit port protocol;
        source_ips = [
          "0.0.0.0/0"
          "::/0"
        ];
      })
      {
        "80" = "tcp";
        "443" = "tcp";
      };
  };
}
