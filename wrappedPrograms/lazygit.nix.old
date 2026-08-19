{
  inputs,
  pkgs,
  ...
}: let
  lazygitConfig = pkgs.writeText "lazygit.yml" (pkgs.lib.generators.toYAML {} {
    gui = {
      showIcons = true;
      nerdFontsVersion = "3";
    };
    customCommands = [
      {
        key = "<c-a>";
        description = "AI-powered conventional commit";
        context = "global";
        command = "git commit -m \"{{.Form.CommitMsg}}\"";
        loadingText = "Generating commit messages...";
        prompts = [
          {
            type = "menu";
            key = "Type";
            title = "Type of change";
            options = [
              {
                name = "feat";
                description = "A new feature";
                value = "feat";
              }
              {
                name = "fix";
                description = "A bug fix";
                value = "fix";
              }
              {
                name = "chore";
                description = "Other changes that don't modify src or test files";
                value = "chore";
              }
              {
                name = "docs";
                description = "Documentation only changes";
                value = "docs";
              }
              {
                name = "refactor";
                description = "A code change that neither fixes a bug nor adds a feature";
                value = "refactor";
              }
              {
                name = "style";
                description = "Changes that do not affect the meaning of the code";
                value = "style";
              }
              {
                name = "test";
                description = "Adding missing tests or correcting existing tests";
                value = "test";
              }
            ];
          }
          {
            type = "input";
            key = "CommitMsg";
            title = "Commit message";
          }
        ];
      }
    ];
  });
in {
  perSystem = {pkgs, ...}: {
    packages.lazygit = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.lazygit;
      env = {
        LAZYGIT_CONFIG_FILE = lazygitConfig;
      };
    };
  };
}
