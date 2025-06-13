from setuptools import setup, find_packages

setup(
    name="auto-profile-tg",
    version="0.0.1",
    scripts=["./auto-profile-tg/main.py"],
    packages=find_packages(include=["assets", "prodile_pics", "utils"]),
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
)