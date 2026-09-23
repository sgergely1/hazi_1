{
	description = "HTML development environment";

	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

	outputs = { self, nixpkgs }:
		let
			systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
			forEachSystem = f: nixpkgs.lib.genAttrs systems (system: f (import nixpkgs {
				inherit system;
				config = { allowUnfree = true; };
			}));
		in
		{
			devShells = forEachSystem (pkgs: {
				default = pkgs.mkShell {
					packages = with pkgs; [
						emmet-language-server
						superhtml
						vscode-langservers-extracted
					];
				};
			});
		};
}
