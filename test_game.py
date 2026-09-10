from playwright.sync_api import sync_playwright

def run_cuj(page):
    page.goto("http://localhost:5173/codemotion-app/")
    page.wait_for_timeout(1000)
    page.evaluate("localStorage.clear()")
    page.goto("http://localhost:5173/codemotion-app/")
    page.wait_for_timeout(1000)

    # 1. Config View: enter end time and submit
    input_locator = page.locator('input[type="time"]')
    input_locator.fill("23:59")
    page.wait_for_timeout(500)
    page.get_by_role("button", name="Salva").click()
    page.wait_for_timeout(1000)

    page.screenshot(path="/home/jules/verification/screenshots/config.png")
    page.get_by_role("button", name="Riprendi Talk").click()
    page.wait_for_timeout(1000)
    page.screenshot(path="/home/jules/verification/screenshots/presentation.png")

    page.get_by_role("button", name="Gioco").click()
    page.wait_for_timeout(1000)
    page.screenshot(path="/home/jules/verification/screenshots/game.png")

if __name__ == "__main__":
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()
        run_cuj(page)
        browser.close()
