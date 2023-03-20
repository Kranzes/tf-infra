{
  terraform.required_providers.hcloud.source = "hetznercloud/hcloud";

  variable."hcloud_token" = {
    description = "Hetzner Cloud API token";
    type = "string";
    sensitive = true;
  };

  provider."hcloud".token = "$\{var.hcloud_token}";

  resource."hcloud_server"."nixos" = {
    name = "nixos";
    server_type = "cpx31";
    image = "fedora-37";
    datacenter = "fsn1-dc14";
    public_net = {
      ipv4_enabled = true;
      ipv6_enabled = true;
    };
  };
}
