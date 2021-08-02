{ sources ? import ./sources.nix
, pkgs ? import sources.nixpkgs {
    overlays = [ (import ./overlays.nix) ];
  }
}:

with pkgs;
let
  ## If you just need an existing package:

  elixir = beam.packages.erlangR23.elixir_1_11;

  ## If you need to override the arguments of an Elixir derivation:

  # elixir = beam.packages.erlangR23.elixir.override {
  #   version = "1.12.2";
  #   sha256 = "1rwmwnqxhjcdx9niva9ardx90p1qi4axxh72nw9k15hhlh2jy29x";
  # };

  ## If you need to override the arguments of an Erlang derivation:

  # erlang = erlangR24.override {
  #   version = "24.0.5";
  #   sha256 = "153kg6351yrkilr4gwg1jh7ifxpz9ar664mz7vdax9sy31q9i771";
  #   configureFlags = [ "--disable-jit" ];
  # };

  # beamPkg = pkgs.beam.packagesWith erlang;

  ## Use Erlang override with:

  # elixir = beamPkg.elixir_1_11;

  ## Or:

  # elixir = beamPkg.elixir.override {
  #   version = "1.12.2";
  #   sha256 = "1rwmwnqxhjcdx9niva9ardx90p1qi4axxh72nw9k15hhlh2jy29x";
  # };

  ## Get sha256 for Elixir with:
  # nix-prefetch-url --unpack https://github.com/elixir-lang/elixir/archive/v${version}.tar.gz

  # Get sha256 for Erlang with:
  # nix-prefetch-url --unpack https://github.com/erlang/otp/archive/OTP-${version}.tar.gz
in

buildEnv {
  name = "builder";
  paths = [
    elixir
    nodejs-14_x
    postgresql_12
  ];
}
