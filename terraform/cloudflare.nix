{
  terraform.required_providers.cloudflare.source = "cloudflare/cloudflare";

  variable."cloudflare_api_token" = {
    description = "Cloudflare API token";
    type = "string";
    sensitive = true;
  };

  provider."cloudflare".api_token = "$\{var.cloudflare_api_token}";

  resource."cloudflare_record" = {
    "jellyfin-ilanjoselevich-com" = {
      name = "jellyfin";
      type = "A";
      value = "84.228.127.28";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      proxied = false;
    };

    "cloud-ilanjoselevich-com" = {
      name = "cloud";
      type = "A";
      value = "84.228.127.28";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      proxied = false;
    };

    "ilanjoselevich-com-netlify" = {
      name = "ilanjoselevich.com";
      type = "CNAME";
      value = "apex-loadbalancer.netlify.com";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      proxied = true;
    };

    "ilanjoselevich-com-autoconfig" = {
      name = "autoconfig";
      type = "CNAME";
      value = "autoconfig.migadu.com";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      proxied = true;
    };

    "ilanjoselevich-com-autodiscover" = {
      name = "autodiscover";
      type = "CNAME";
      value = "autodiscover.migadu.com";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      proxied = true;
    };

    "ilanjoselevich-com-key1-domainkey" = {
      name = "key1._domainkey";
      type = "CNAME";
      value = "key1.ilanjoselevich.com._domainkey.migadu.com";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      proxied = true;
    };

    "ilanjoselevich-com-key2-domainkey" = {
      name = "key2._domainkey";
      type = "CNAME";
      value = "key2.ilanjoselevich.com._domainkey.migadu.com";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      proxied = true;
    };

    "ilanjoselevich-com-key3-domainkey" = {
      name = "key3._domainkey";
      type = "CNAME";
      value = "key3.ilanjoselevich.com._domainkey.migadu.com";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      proxied = true;
    };

    "ilanjoselevich-com-migadu-MX-1" = {
      name = "ilanjoselevich.com";
      type = "MX";
      value = "aspmx1.migadu.com";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      priority = 10;
      proxied = false;
    };

    "ilanjoselevich-com-migadu-MX-2" = {
      name = "ilanjoselevich.com";
      type = "MX";
      value = "aspmx2.migadu.com";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      priority = 20;
      proxied = false;
    };

    "ilanjoselevich-com-dmarc" = {
      name = "ilanjoselevich.com";
      type = "TXT";
      value = "v=DMARC1; p=reject;";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      proxied = false;
    };

    "ilanjoselevich-com-spf" = {
      name = "ilanjoselevich.com";
      type = "TXT";
      value = "v=spf1 include:spf.migadu.com -all";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      proxied = false;
    };

    "ilanjoselevich-com-ieogkobz" = {
      name = "ilanjoselevich.com";
      type = "TXT";
      value = "hosted-email-verify=ieogkobz";
      zone_id = "6e142c5060409755f7d8c863f026d228";
      proxied = false;
    };
  };
}
