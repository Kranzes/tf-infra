{ withSystem, config, inputs, ... }:

{
  herculesCI = herculesCI: {
    onPush.default.outputs.effects.terraform-deploy = withSystem config.defaultEffectSystem ({ pkgs, config, hci-effects, ... }:
      hci-effects.mkEffect {
        name = "terraform-deploy";
        inputs = [
          config.packages.terraform-with-plugins
          pkgs.rage
        ];
        secretsMap.terraform-secret = "terraform-secret";
        tfstateName = "encrypted-terraform.tfstate";
        tfvarsPath = "${inputs.self}/secrets/terraform.tfvars.age";
        ageRecipient = "age1fdqe6xc4q2vf4e5cc4w9qg52hdp9gz3zmgag90plh52ed3rdtgcq7mw97w";
        TF_IN_AUTOMATION = 1;
        TF_INPUT = 0;
        TF_CLI_ARGS_init = "-compact-warnings";
        getStateScript = ''
          stateFileName="$PWD/$tfstateName"
          getStateFile "$tfstateName" "$stateFileName"

          readSecretString terraform-secret .ageKey > age-key.txt
          rage --identity age-key.txt --decrypt "$stateFileName" --output terraform.tfstate
        '';
        userSetupPhase = ''
          rage --identity age-key.txt --decrypt "$tfvarsPath" --output terraform.tfvars
          ln -s ${config.packages.terraformConfiguration} config.tf.json
          terraform init
        '';
        priorCheckScript = "terraform validate";
        effectScript = if (herculesCI.config.repo.branch == "master") then "terraform apply -auto-approve" else "terraform plan";
        putStateScript = ''
          rage --recipient "$ageRecipient" --encrypt terraform.tfstate --output "$stateFileName"
          putStateFile "$tfstateName" "$stateFileName"
          echo "Cleaning up..."
          rm terraform.{tfstate,tfvars} encrypted-terraform.tfstate age-key.txt
        '';
      }
    );
  };
}
