flake: { config, lib, pkgs, ...}:
let
  pkg = flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
  cfg = config.services.auto-profile-tg;
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
        # enable = true;
        serviceConfig = {
          Program = "${pkg}/bin/main.py";
          # ProgramArguments = ["${auto-profile-tg}/bin/main.py" "--API_ID=${}" "--API_HASH=${}"]; do .env parsing
          KeepAlive = true;
          RunAtLoad = true;
          # EnvironmentVariables.PATH = "${pkgs.restic}/bin:/usr/bin";
        };
      };
    };
  };
}
