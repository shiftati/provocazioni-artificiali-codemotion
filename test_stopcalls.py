from playwright.sync_api import sync_playwright

def run_cuj(page):
    page.goto("http://localhost:5173/codemotion-app/")
    page.wait_for_timeout(1000)
    page.evaluate("localStorage.clear()")
    page.goto("http://localhost:5173/codemotion-app/")
    page.wait_for_timeout(1000)

    # Set timer to end very soon (1 minute from now is hard to simulate via input without evaluate, so let's do it directly in local storage)
    page.evaluate("""
        const end = new Date(Date.now() + 2000);
        const data = { version: 1, data: { endTime: '12:00', endTimestamp: end.getTime() } };
        localStorage.setItem('codemotion-app:config', JSON.stringify(data));
    """)
    page.goto("http://localhost:5173/codemotion-app/")
    page.wait_for_timeout(3000) # Wait 3s so timer hits 0

    page.screenshot(path="/home/jules/verification/screenshots/stopcalls.png")

if __name__ == "__main__":
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()
        run_cuj(page)
        browser.close()
