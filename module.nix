flake: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.auto-profile-tg;
  pkg = flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
  homeDir = config.users.users.bahrom04.home;
  
in {
  options = {
    services.auto-profile-tg = {
      enable = lib.mkEnableOption "auto-profile-tg";

      # Telegram API credentials from my.telegram.org
      app-id = lib.mkOption {
        type = lib.types.int;
        default = 0;
        example = 12345678;
      };

      api-hash = lib.mkOption {
        type = lib.types.str;
        default = "";
      };

      phone-number = lib.mkOption {
        type = lib.types.str;
        example = "+998123456789";
      };

      first-name = lib.mkOption {
        type = lib.types.str;
        example = "John";
      };

      lat = lib.mkOption {
        type = lib.types.str;
        example = "41.2995";
      };

      lon = lib.mkOption {
        type = lib.types.str;
        example = "69.2401";
      };

      timezone = lib.mkOption {
        type = lib.types.str;
        example = "Asia/Tashkent";
      };

      city = lib.mkOption {
        type = lib.types.str;
        example = "Tashkent";
      };

      weather-api-key = lib.mkOption {
        type = lib.types.str;
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
    launchd.user.agents = {
      auto-profile-tg = {
        serviceConfig = {
          # Program = "${pkg}/bin/runner";
          ProgramArguments = [
            "${pkg}/bin/runner" 
            "--api_id=${cfg.api-id}" 
            "--api_hash=${cfg.api-hash}" 
            "--phone_number=${cfg.phone-number}" 
            "--first_name=${cfg.first-name}"
            "--lat=${cfg.lat}"
            "--lon=${cfg.lon}"
            "--timezone=${cfg.timezone}"
            "--city=${cfg.city}"
            "--weather_api_key=${cfg.weather-api-key}"
            ]; 
          StandardOutPath = "/${homeDir}/Library/Logs/auto-profile-tg.log";
          StandardErrorPath = "/${homeDir}/Library/Logs/auto-profile-tg-error.log";
          KeepAlive = true;
          RunAtLoad = true;
        };
      };
    };
  };
}
