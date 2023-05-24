{ lib, ... }:

{
  resource = {
    "cloudflare_zone"."yaelcohen-net" = {
      account_id = "1656f2ec8d770671a75433aa3848a111";
      zone = "yaelcohen.net";
    };

    "cloudflare_pages_project"."yaelcohen-net" = {
      name = "yaelcohen-net";
      account_id = lib.tfRef "cloudflare_zone.yaelcohen-net.account_id";
      production_branch = "master";
    };

    "cloudflare_pages_domain"."yaelcohen-net" = {
      project_name = lib.tfRef "cloudflare_pages_project.yaelcohen-net.name";
      account_id = lib.tfRef "cloudflare_pages_project.yaelcohen-net.account_id";
      domain = "yaelcohen.net";
    };

    "cloudflare_record" = {
      "yaelcohen-net" = {
        name = "yaelcohen.net";
        type = "CNAME";
        value = (lib.tfRef "cloudflare_pages_project.yaelcohen-net.name") + ".pages.dev";
        zone_id = lib.tfRef "cloudflare_zone.yaelcohen-net.id";
        proxied = true;
      };

      "mail-yaelcohen-net" = {
        name = "mail";
        type = "A";
        value = "208.76.80.21";
        zone_id = lib.tfRef "cloudflare_zone.yaelcohen-net.id";
        proxied = false;
      };

      "yaelcohen-net-spf" = {
        name = "yaelcohen.net";
        type = "TXT";
        value = "v=spf1 ip4:208.76.80.21 +a +mx +ip4:208.76.80.109 include:relay.mailchannels.net ~all";
        zone_id = lib.tfRef "cloudflare_zone.yaelcohen-net.id";
        proxied = false;
      };

      "yaelcohen-net-dmarc" = {
        name = "_dmarc";
        type = "TXT";
        value = "v=DMARC1; p=reject;";
        zone_id = lib.tfRef "cloudflare_zone.yaelcohen-net.id";
        proxied = false;
      };

      "yaelcohen-net-MX" = {
        name = "yaelcohen.net";
        type = "MX";
        value = "mail.yaelcohen.net";
        zone_id = lib.tfRef "cloudflare_zone.yaelcohen-net.id";
        priority = 1;
        proxied = false;
      };
    };
  };
}
