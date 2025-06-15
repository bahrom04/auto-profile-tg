import os, argparse
from dotenv import load_dotenv
from loguru import logger

load_dotenv()

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


def _safe_int(key: str, default: int = 0) -> int:
    """Safely convert environment variable to int, logging warning if conversion fails."""
    try:
        return int(os.getenv(key, default))
    except ValueError:
        logger.warning(f"Invalid int for {key}, defaulting to {default}")
        return default


def _safe_float(key: str, default: float = 0.0) -> float:
    """Safely convert environment variable to float, logging warning if conversion fails."""
    try:
        return float(os.getenv(key, default))
    except ValueError:
        logger.warning(f"Invalid float for {key}, defaulting to {default}")
        return default


# Telegram API credentials
API_ID = f"{args.api_id}"
API_HASH = f"{args.api_hash}"
PHONE_NUMBER = f"{args.phone-number}"

# User credentials
FIRST_NAME = f"{args.first_name}"

# Weather API key
WEATHER_API_KEY = f"{args.weather_api_key}"
if not WEATHER_API_KEY:
    logger.warning("Missing WEATHER_API_KEY")

# Geographic coordinates and timezone
LAT =f"{args.lat}"
LON = f"{args.lon}"
TIMEZONE = f"{args.timezone}"
CITY = f"{args.city}"

logger.info(f"Config loaded: CITY={CITY}, TIMEZONE={TIMEZONE}, LAT={LAT}, LON={LON}")
