# tutorial: https://blog.stigok.com/2019/11/05/packing-python-script-binary-nicely-in-nixos.html
# reference: https://nixos.org/manual/nixpkgs/stable/#buildpythonpackage-function
{
  fetchFromGitHub,
  python3,
  fetchPypi,
  # , python3Packages
}:
python3.pkgs.buildPythonPackage rec {
  pname = "auto-profile-tg";
  version = "0.0.1";
  format = "pyproject";
  src = fetchFromGitHub {
    owner = "bahrom04";
    repo = "auto-profile-tg";
    rev = "master";
    sha256 = "sha256-TVhiSEBDizP+rojMb/vxNuZB9Y5cjmXqgib5Y/T8DEA=";
  };

  propagatedBuildInputs = with python3.pkgs; [
    pip
    APScheduler
    loguru
    python-dotenv
    pytz
    requests
    tenacity
    telethon
    setuptools
  ];

  nativeBuildInputs = with python3.pkgs;[
    poetry-core
    flit-core
  ];
  # No tests
  doCheck = false;

  meta = {
    description = "auto-profile adds real-time clock to your telegram profile username";
  };
}
