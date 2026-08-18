{
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.git = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.gitFull;
      env = rec {
        GIT_AUTHOR_NAME = "jvegaf";
        GIT_AUTHOR_EMAIL = "72362399+jvegaf@users.noreply.github.com";
        GIT_COMMITTER_NAME = GIT_AUTHOR_NAME;
        GIT_COMMITTER_EMAIL = GIT_AUTHOR_EMAIL;
      };
    };
  };
}
