{
  description = "Custom ST build";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system}.default = pkgs.st.overrideAttrs (oldAttrs: {
      patches = [
        ./patches/st-anysize-0.8.4.diff
        ./patches/st-boxdraw_v2-0.8.5.diff
        ./patches/st-scrollback-0.9.2.diff
        ./patches/st-scrollback-mouse-0.9.2.diff
      ];

      postPatch = ''
      cp ${./config.h} config.h
      '';
    });
  };
}
