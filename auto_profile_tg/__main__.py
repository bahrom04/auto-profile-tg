from auto_profile_tg.main import main
import asyncio
from loguru import logger

def runner():
    try:
        asyncio.run(main())
    except (KeyboardInterrupt, SystemExit):
        logger.warning("Bot stopped by user.")