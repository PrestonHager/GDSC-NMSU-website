{
  description = "Development shell for Flutter project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: {
    devShells = let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
      default = pkgs.mkShell {
        packages = with pkgs; [
          flutter
        ];
      };

      nu = pkgs.mkShell {
        packages = with pkgs; [
          flutter
          nushell
        ];

        env = {
          CHROME_EXECUTABLE = "${pkgs.brave}/bin/brave";
        };

        shellHook = ''
          exec nu
        '';
      };
    };
  });
}

