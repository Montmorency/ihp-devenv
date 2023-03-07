{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "Welcome to IHP Environment";

  # https://devenv.sh/packages/
  packages = [ pkgs.git ];

  # https://devenv.sh/scripts/
  scripts.hello.exec = "echo hello from $GREET";

  enterShell = ''
    hello
    git --version
  '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # https://devenv.sh/processes/
    services.postgres.enable = true; 
  # see https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/sql/postgresql/packages.nix for full list
    services.postgres.package = postgresql_13.withPackages (p: [ p.pg_cron p.timescaledb p.pg_partman ]);
    services.postgres.initdbArgs =  ["-D", "build/db/state", "-k", "./build/db", "-c", "listen_addresses="]
    services.postgres.initialScript = ''CREATE EXTENSION IF NOT EXISTS "uuid-ossp";''

  # See full reference at https://devenv.sh/reference/options/
}
