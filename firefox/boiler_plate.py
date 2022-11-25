"""Restores backup with custom filter settings to Ublock."""

website_controller = Website_controller()
website_controller.driver = open_url(website_controller.driver, login_url)
website_controller.driver.implicitly_wait(6)
username_input = website_controller.driver.find_element(
    "id", user_element_id
)