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

  preBuild = ''
    cat > setup.py << EOF
    from setuptools import setup, find_packages

    with open('./auto-profile-tg/requirements.txt') as f:
        install_requires = f.read().splitlines()

    setup(
      name="auto-profile-tg",
      packages=find_packages(include=["assets", "prodile_pics", "utils"]),
      version='0.1.0',
      #author='...',
      #description='...',
      install_requires=[
        "APScheduler==3.11.0",
        "loguru==0.7.3",
        "python-dotenv==1.1.0",
        "pytz==2025.2",
        "requests==2.32.4",
        "Telethon==1.40.0",
        "tenacity==9.1.2",
        "setuptools",
      ]
      scripts=[
        './auto-profile-tg/main.py',
      ],
      entry_points={
        # example: file some_module.py -> function main
        #'console_scripts': ['someprogram=auto-profile-tg:main']
      },
    )
        EOF
  '';

  # No tests
  doCheck = false; 

  meta = {
    description = "auto-profile adds real-time clock to your telegram profile username";
  };
}