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
  # src =./auto-profile-tg;
  src = fetchFromGitHub {
    owner = "bahrom04";
    repo = "auto-profile-tg";
    rev = "master";
    sha256 = "sha256-vIsCQZqMEap2fF4dsH25Mu6ogbXAIWHv5PCISLS7Q/s=";
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

  postPatch = ''
    chmod +x ./auto_profile_tg/main.py
  '';

  preBuild = ''
  cat > setup.py <<EOF
from setuptools import setup, find_packages

with open('./auto_profile_tg/requirements.txt') as f:
    install_requires = f.read().splitlines()

setup(
  name="auto-profile-tg",
  packages=find_packages(include=["auto_profile_tg", "auto_profile_tg.*"]),
  version='0.1.0',
  install_requires=install_requires,

  entry_points={
    'console_scripts': ['auto-profile-tg = auto_profile_tg.main:main']
  }
)
EOF
'';

  # No tests
  doCheck = false;

  meta = {
    description = "auto-profile adds real-time clock to your telegram profile username";
  };
}
