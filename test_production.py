import asyncio
from playwright.async_api import async_playwright
import os

async def main():
    async with async_playwright() as p:
        browser = await p.chromium.launch()
        page = await browser.new_page()
        # Mocking GitHub pages behaviour by starting a server on dist
        import subprocess
        proc = subprocess.Popen(["npx", "serve", "dist", "-p", "3000"])
        await asyncio.sleep(2)
        try:
            await page.goto("http://localhost:3000/")
            await page.wait_for_timeout(2000)
            print("Loaded without 404!")
            print(f"Title: {await page.title()}")
        finally:
            proc.terminate()
            await browser.close()

if __name__ == "__main__":
    asyncio.run(main())
