from selenium import webdriver

url = "https://startpagina.nl"

driver = webdriver.Firefox()
driver.get(url)

elements = driver.find_elements_by_xpath("//*")
# test = driver.find_elements_by_xpath('/html/body/')
# test = driver.find_elements_by_xpath('/html/body/div[6]')
# test = driver.find_elements_by_xpath('/html/body/div[6]/div[2]/div[1]/div[2]/div/div[2]/form/input[2]')
print(len(elements))
driver.close()

print(elements[0].__dict__)