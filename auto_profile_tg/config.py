import argparse
from pathlib import Path
from loguru import logger


parser = argparse.ArgumentParser(description="run application")
parser.add_argument("--api_id", required=True)
parser.add_argument("--api_hash", required=True)
parser.add_argument("--phone_number", required=True)
parser.add_argument("--first_name", required=True)
parser.add_argument("--lat", required=True)
parser.add_argument("--lon", required=True)
parser.add_argument("--timezone", required=True)
parser.add_argument("--city", required=True)
parser.add_argument("--weather_api_key", required=True)

args = parser.parse_args()


class Config:
    def __init__(self, args, production: bool):
        def set_env_variables(key_path: str):
            """Safely convert sops environment variable from this /run/secrets/api_id to actual key"""
            try:
                content = Path(key_path).read_text().strip()
                logger.info("reading file: ", content)
                return str(content)
            except Exception as e:
                logger.warning(f"Invalid env for {key_path}: {e}")
                return e
            
        def val(x):
            return set_env_variables(key_path=x) if production == True else x
        
        self.API_ID = val(args.api_id)
        self.API_HASH = val(args.api_hash)
        self.PHONE_NUMBER = val(args.phone_number)
        self.FIRST_NAME = val(args.first_name)
        self.WEATHER_API_KEY = val(args.weather_api_key)
        self.LAT = val(args.lat)
        self.LON = val(args.lon)
        self.TIMEZONE = val(args.timezone)
        self.CITY = val(args.city)

config = Config(args, production=True)
        
logger.info(f"Config loaded: CITY={config.CITY}, TIMEZONE={config.TIMEZONE}, LAT={config.LAT}, LON={config.LON}")
