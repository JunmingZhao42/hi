let
    pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    buildInputs = with pkgs.buildPackages; [
	python312Packages.pandas
	python312Packages.numpy
	python312Packages.matplotlib
    ];
}

