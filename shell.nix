# reference: https://nixos.wiki/wiki/Packaging/Python

{ 
python3,
}:

python3.pkgs.buildPythonPackage rec {
  name = "auto-profile-tg";
  scr = "./auto-profile-tg";
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
}