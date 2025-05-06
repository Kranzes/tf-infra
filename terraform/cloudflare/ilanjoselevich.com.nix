{ lib, ... }:

{
  resource = {
    "cloudflare_zone"."ilanjoselevich-com" = {
      account_id = "1656f2ec8d770671a75433aa3848a111";
      zone = "ilanjoselevich.com";
    };

    "cloudflare_pages_project"."ilanjoselevich-com" = {
      name = "ilanjoselevich-com";
      account_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.account_id";
      production_branch = "master";
    };

    "cloudflare_pages_domain"."ilanjoselevich-com" = {
      project_name = lib.tfRef "cloudflare_pages_project.ilanjoselevich-com.name";
      account_id = lib.tfRef "cloudflare_pages_project.ilanjoselevich-com.account_id";
      domain = "ilanjoselevich.com";
    };

    "cloudflare_record" = {
      "ilanjoselevich-com" = {
        name = "ilanjoselevich.com";
        type = "CNAME";
        value = (lib.tfRef "cloudflare_pages_project.ilanjoselevich-com.name") + ".pages.dev";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = true;
      };

      "idm-ilanjoselevich-com" = {
        name = "idm";
        type = "A";
        value = lib.tfRef "hcloud_server.nixos.ipv4_address";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = true;
      };

      "monitoring-ilanjoselevich-com" = {
        name = "monitoring";
        type = "A";
        value = lib.tfRef "hcloud_server.nixos.ipv4_address";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = true;
      };

      "push-ilanjoselevich-com" = {
        name = "push";
        type = "A";
        value = lib.tfRef "hcloud_server.nixos.ipv4_address";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = true;
      };

      "portal-ilanjoselevich-com" = {
        name = "portal";
        type = "A";
        value = lib.tfRef "hcloud_server.nixos.ipv4_address";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = true;
      };

      "cloud-ilanjoselevich-com" = {
        name = "cloud";
        type = "A";
        value = "84.228.127.28";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = false;
      };

      "jellyfin-ilanjoselevich-com" = {
        name = "jellyfin";
        type = "A";
        value = "84.228.127.28";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = false;
      };

      "ilanjoselevich-com-autoconfig" = {
        name = "autoconfig";
        type = "CNAME";
        value = "autoconfig.migadu.com";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = true;
      };

      "ilanjoselevich-com-autodiscover" = {
        name = "autodiscover";
        type = "CNAME";
        value = "autodiscover.migadu.com";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = true;
      };

      "ilanjoselevich-com-key1-domainkey" = {
        name = "key1._domainkey";
        type = "CNAME";
        value = "key1.ilanjoselevich.com._domainkey.migadu.com";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = true;
      };

      "ilanjoselevich-com-key2-domainkey" = {
        name = "key2._domainkey";
        type = "CNAME";
        value = "key2.ilanjoselevich.com._domainkey.migadu.com";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = true;
      };

      "ilanjoselevich-com-key3-domainkey" = {
        name = "key3._domainkey";
        type = "CNAME";
        value = "key3.ilanjoselevich.com._domainkey.migadu.com";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = true;
      };

      "ilanjoselevich-com-migadu-MX-1" = {
        name = "ilanjoselevich.com";
        type = "MX";
        value = "aspmx1.migadu.com";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        priority = 10;
        proxied = false;
      };

      "ilanjoselevich-com-migadu-MX-2" = {
        name = "ilanjoselevich.com";
        type = "MX";
        value = "aspmx2.migadu.com";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        priority = 20;
        proxied = false;
      };

      "ilanjoselevich-com-dmarc" = {
        name = "_dmarc";
        type = "TXT";
        value = "v=DMARC1; p=reject;";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = false;
      };

      "ilanjoselevich-com-spf" = {
        name = "ilanjoselevich.com";
        type = "TXT";
        value = "v=spf1 include:spf.migadu.com -all";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = false;
      };

      "ilanjoselevich-com-ieogkobz" = {
        name = "ilanjoselevich.com";
        type = "TXT";
        value = "hosted-email-verify=ieogkobz";
        zone_id = lib.tfRef "cloudflare_zone.ilanjoselevich-com.id";
        proxied = false;
      };
    };
  };
}
