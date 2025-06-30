{
  description = "My custom nix packages";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];

      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];

      # ── Packages go here ──────────────────────────────────────────────────
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = { clangd-21 = pkgs.callPackage ./clangd/clangd-21.nix { }; };
      };
      # ──────────────────────────────────────────────────────────────────────

      flake = { };
    };
}
