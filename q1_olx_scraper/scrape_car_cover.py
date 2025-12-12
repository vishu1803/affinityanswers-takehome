from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from tabulate import tabulate

SEARCH_URL = "https://www.olx.in/items/q-car-cover?isSearchCall=true"


def fetch_listings():
    """
    Open the OLX search URL in a headless Chrome browser,
    wait for listings to load, and extract title, location, and price.
    """
    options = webdriver.ChromeOptions()
    # Headless browser so no window pops up
    options.add_argument("--headless=new")
    options.add_argument("--disable-gpu")
    options.add_argument("--no-sandbox")
    options.add_argument("--window-size=1920,1080")
    options.add_argument(
        "user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/120.0 Safari/537.36"
    )

    driver = webdriver.Chrome(options=options)

    try:
        driver.get(SEARCH_URL)

        
        wait = WebDriverWait(driver, 20)
        wait.until(
            EC.presence_of_element_located(
                (By.CSS_SELECTOR, 'li[data-aut-id^="itemBox"]')
            )
        )

        cards = driver.find_elements(By.CSS_SELECTOR, 'li[data-aut-id^="itemBox"]')

        listings = []

        for card in cards:
            try:
                title_el = card.find_element(By.CSS_SELECTOR, '[data-aut-id="itemTitle"]')
            except Exception:
                title_el = None

            try:
                price_el = card.find_element(By.CSS_SELECTOR, '[data-aut-id="itemPrice"]')
            except Exception:
                price_el = None

            try:
                location_el = card.find_element(
                    By.CSS_SELECTOR, '[data-aut-id="item-location"]'
                )
            except Exception:
                location_el = None

            title = title_el.text.strip() if title_el else "N/A"
            price = price_el.text.strip() if price_el else "N/A"
            # Search results don’t show a full description, so we use location as a short description
            description = location_el.text.strip() if location_el else "N/A"

            listings.append(
                {
                    "title": title,
                    "description": description,
                    "price": price,
                }
            )

        return listings

    finally:
        driver.quit()


def print_table(listings):
    """
    Print the listings in a table format.
    """
    if not listings:
        print("No listings found.")
        return

    table_data = [
        [idx + 1, item["title"], item["description"], item["price"]]
        for idx, item in enumerate(listings)
    ]
    headers = ["#", "Title", "Description (location)", "Price"]
    print(tabulate(table_data, headers=headers, tablefmt="github"))


def main():
    try:
        listings = fetch_listings()
    except Exception as e:
        print(f"Error fetching listings: {e}")
        return

    print_table(listings)


if __name__ == "__main__":
    main()
