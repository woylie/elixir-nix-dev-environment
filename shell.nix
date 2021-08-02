{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs {
    overlays = [ (import ./nix/overlays.nix) ];
  }
}:

with pkgs;
let
  inherit (lib) optional optionals;
in

mkShell {
  buildInputs = [
    (import ./nix/default.nix { inherit pkgs; })
    niv
  ] ++ optional stdenv.isLinux inotify-tools
  ++ optional stdenv.isDarwin terminal-notifier
  ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
    CoreFoundation
    CoreServices
  ]);
}
