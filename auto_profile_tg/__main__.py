from auto_profile_tg.main import main
import asyncio
from loguru import logger


if __name__ == "__main__":
    try:
        asyncio.run(main())
    except (KeyboardInterrupt, SystemExit):
        logger.warning("Bot stopped by user.")