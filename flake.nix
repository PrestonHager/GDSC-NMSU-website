{
  description = "Development shell for Flutter project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system: {
    devShells = let
      pkgs = import nixpkgs { inherit system; };
      basePackages = with pkgs; [ flutter ];
      nuPackages = with pkgs; [ flutter nushell ];
      browserPackages = {
        chrome = with pkgs; [ google-chrome ];
        brave = with pkgs; [ brave ];
      };
      makeShell = { name, packages, shellHook ? null, env ? null }: pkgs.mkShell {
        inherit packages;
        inherit shellHook;
        inherit env;
      };
    in {
      base = makeShell {
        name = "base";
        packages = basePackages;
      };
      "base-chrome" = makeShell {
        name = "base-chrome";
        packages = basePackages ++ browserPackages.chrome;
        env.CHROME_EXECUTABLE = "${pkgs.chrome}/bin/google-chrome";
      };
      "base-brave" = makeShell {
        name = "base-brave";
        packages = basePackages ++ browserPackages.brave;
        env.CHROME_EXECUTABLE = "${pkgs.brave}/bin/brave";
      };
      nu = makeShell { name = "nu";
        packages = nuPackages;
        shellHook = ''exec nu'';
      };
      "nu-chrome" = makeShell { name = "nu-chrome";
        packages = nuPackages ++ browserPackages.chrome;
        shellHook = ''exec nu'';
        env.CHROME_EXECUTABLE = "${pkgs.chrome}/bin/google-chrome";
      };
      "nu-brave" = makeShell { name = "nu-brave";
        packages = nuPackages ++ browserPackages.brave;
        shellHook = ''exec nu'';
        env.CHROME_EXECUTABLE = "${pkgs.brave}/bin/brave";
      };
    };
  });
}

