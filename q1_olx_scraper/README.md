📌 Q1 – OLX Car Cover Scraper (Python + Selenium)

This project extracts real, live OLX listings for the search term “car cover” from the URL:

https://www.olx.in/items/q-car-cover?isSearchCall=true


and outputs the following fields for each ad:

Title

Description (location shown in the card)

Price

The results are printed in a clean Markdown-style table.

🚨 Why Selenium?

The provided OLX URL is fully JavaScript-rendered, meaning:

A normal requests.get() returns only an empty HTML shell.

Ads appear only after JavaScript runs in the browser.

Therefore, Selenium with headless Chrome is used to load the page like a real user, allow JavaScript to execute, and then scrape the fully rendered DOM.

This guarantees correct extraction of real live OLX data from the required URL.

🛠️ Project Files
q1_olx_scraper/
│── scrape_car_cover.py
│── requirements.txt
│── README.md

📦 Installation

Create and activate a virtual environment:

python -m venv venv
source venv/Scripts/activate   # Windows Git Bash


Install dependencies:

pip install -r requirements.txt


Selenium ≥ 4.10 automatically installs the correct ChromeDriver.

▶️ Running the Script
python scrape_car_cover.py


The script will:

Launch headless Chrome

Open the OLX URL

Execute page JavaScript

Extract:

Title → data-aut-id="itemTitle"

Price → data-aut-id="itemPrice"

Description (location) → data-aut-id="item-location"

Print the results in a table, for example:

|   # | Title                               | Description (location)   | Price   |
|-----|-------------------------------------|---------------------------|---------|
|   1 | Premium Car Cover XYZ               | Bengaluru, Karnataka      | ₹1,499  |
|   2 | Waterproof Car Cover for Sedan      | Pune, Maharashtra         | ₹899    |

🔍 HTML Structure Used

From OLX page source (DevTools):

<li data-aut-id="itemBox3">
    <span data-aut-id="itemPrice">₹ 2,499</span>
    <span data-aut-id="itemTitle">All cars side mirror batman cover...</span>
    <span data-aut-id="item-location">Gangtok Private Estate, Gangtok</span>
</li>


Selectors used:

li[data-aut-id^="itemBox"]

[data-aut-id="itemTitle"]

[data-aut-id="itemPrice"]

[data-aut-id="item-location"]

These attributes are stable and reliable for scraping.

🧠 Notes

The scraper uses the exact URL provided in the assignment.

All listings come from real live OLX data, not cached or mock HTML.

Uses modern Selenium + headless Chrome, which avoids OLX bot-blocking seen with requests.

Only first-page results are extracted (per question requirement).

Output is printed in Markdown table format for readability.