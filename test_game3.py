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

    page.get_by_role("button", name="Riprendi Talk").click()
    page.wait_for_timeout(1000)

    page.get_by_role("button", name="Gioco").click()
    page.wait_for_timeout(1000)

    page.get_by_role("button", name="Play").click()
    page.wait_for_timeout(1000)

    page.get_by_role("button", name="Accetta").click()
    page.wait_for_timeout(1000)

if __name__ == "__main__":
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        context = browser.new_context(
            record_video_dir="/home/jules/verification/videos"
        )
        page = context.new_page()
        try:
            run_cuj(page)
        except Exception as e:
            print("Error:", e)
        finally:
            context.close()
            browser.close()
