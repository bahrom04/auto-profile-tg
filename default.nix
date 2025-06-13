# tutorial: https://blog.stigok.com/2019/11/05/packing-python-script-binary-nicely-in-nixos.html
# reference: https://nixos.org/manual/nixpkgs/stable/#buildpythonpackage-function
{ 
fetchFromGitHub
, python3
, fetchPypi
, python3Packages
}:

python3.pkgs.buildPythonApplication rec {
  pname = "auto-profile-tg";
  version = "0.0.1";

  # src =./auto-profile-tg;

  src = fetchFromGitHub {
    owner = "bahrom04";
    repo = "auto-profile-tg";
    rev = "master";
    sha256 = "sha256-/8vMARRhxSsZlwjsrnLLdzwOYHZtEFvb1Hhm1ka8SKQ=";
  };

  propagatedBuildInputs = with python3Packages; [
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
  

  # postPatch = ''
  #   cp ${src}/requirements.txt .
  # '';

  # preBuild = ''
  #   pip install --prefix=$out -r requirements.txt
  # '';

  # No tests
  doCheck = false; 

  meta = {
    description = "auto-profile adds real-time clock to your telegram profile username";
  };
}