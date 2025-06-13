{ config, lib, pkgs, ...}:
let
  auto-profile-tg = pkgs.callPackage ./default.nix {};

  cfg = config.auto-profile-tg;

in {
  options = with lib; {
    auto-profile-tg = {
      enable = mkEnableOption "auto-profile-tg";

      # Telegram API credentials from my.telegram.org
      app-id = mkOption {
        type = types.int;
        default = 0;
        example = 12345678;
      };

      api-hash = mkOption {
        type = types.str;
        default = "";
      };

      phone-number = mkOption {
        type = types.str;
        example = "+998123456789";
      };

      first-name = mkOption {
        type = types.str;
        example = "John";
      };

      lat = mkOption {
        type = types.str;
        example = "41.2995";
      };

      lon = mkOption {
        type = types.str;
        example = "69.2401";
      };
      
      timezone = mkOption {
        type = types.str;
        example = "Asia/Tashkent";
      };
      
      city = mkOption {
        type = types.str;
        example = "Tashkent";
      };

      weather-api-key = mkOption {
        type = types.str;
      };
    };
  };
 
  config = lib.mkIf cfg.enable {
    # systemd.services.auto-profile-tg = {
    #   description = "run the bot on systemd";
    #   environment = {
    #     PYTHONUNBUFFERED = "1";
    #   };
      
    #   after = [ "network.target" ];
    #   wantedBy = [ "network.target" ];

    #   ExecStart = "${auto-profile-tg}/bin/main.py";
    #   Restart = "always";
    #   RestartSec = "5";
    # };

    # I use mac btw
    launchd.agents = {
      auto-profile-tg = {
        enable = true;
        config = {
          Program = "${auto-profile-tg}/bin/main.py";
          # ProgramArguments = ["${auto-profile-tg}/bin/main.py" "--API_ID=${}" "--API_HASH=${}"]; do .env parsing
          KeepAlive = true;
          RunAtLoad = true;
          # EnvironmentVariables.PATH = "${pkgs.restic}/bin:/usr/bin";
        };
      }
    };
  };
}