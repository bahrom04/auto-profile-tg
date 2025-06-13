# tutorial: https://blog.stigok.com/2019/11/05/packing-python-script-binary-nicely-in-nixos.html

{ nixpkgs ? import <nixpkgs> {}, pythonPkgs ? nixpkgs.pkgs.python312Packages }:

let 
  inherit (nixpkgs) pkgs;
  inherit pythonPkgs;

  f = { buildPythonPackage, bottle, requests }:
    buildPythonPackage rec {
      pname = "auto-profile-tg";
      version = "0.0.1";

      # If you have your sources locally, you can specify a path
      # src = /Users/bahrom04/workplace/open-sors/auto-profile;

      # Pull source from a Git server. Optionally select a specific `ref` (e.g. branch),
      # or `rev` revision hash.
      src = builtins.fetchGit {
        url = "git://github.com:bahrom04/auto-profile.git";
        ref = master;
      };

      # Specify runtime dependencies for the package
      propagatedBuildInputs = [ 
        # APScheduler
        # loguru 
        # python-dotenv 
        # pytz 
        # Telethon
        # tenacity
        # setuptools
        requests
        ];

        # No tests
        doCheck = false; 

        # Meta information for the package
        meta = {
          description = "auto-profile adds real-time clock to your telegram profile username";
        };
    };

    drv = pythonPkgs.callPackage f{};
in 
  if pkgs.lib.inNixShell then drv.env else drv