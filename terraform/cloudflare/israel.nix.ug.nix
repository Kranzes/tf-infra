{
  resource = {
    "cloudflare_pages_project"."israel-nix-ug" = {
      name = "israel-nix-ug";
      account_id = "$\{cloudflare_zone.ilanjoselevich-com.account_id}";
      production_branch = "master";
    };

    "cloudflare_pages_domain"."israel-nix-ug" = {
      project_name = "$\{cloudflare_pages_project.israel-nix-ug.name}";
      account_id = "$\{cloudflare_pages_project.israel-nix-ug.account_id}";
      domain = "israel.nix.ug";
    };
  };
}
