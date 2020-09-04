from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.chrome.options import Options

import pandas as pd
import time

# read link sources
link = pd.read_csv('link.csv')
chromedriver = "chromedriver_linux64/chromedriver"

# scrape the pagess
d = pd.DataFrame()
for i in link.link:
    url = i
    driver = webdriver.Chrome(executable_path=chromedriver)
    driver.get(url)
    time.sleep(6)
    for j in range(22, 1002 , 20):
        driver.find_element_by_xpath('//*[@id="container"]/main/div/section/div/div/div[4]/div[2]/div/div[2]/ul/li['+str(j)+']/div/button/span').click()
        time.sleep(6)
    html_source = driver.page_source
    soup = BeautifulSoup(html_source, "html.parser") 
    page = soup.body.find('ul', attrs={'class': 'rl3f9 _3mXOU'})
    
    df = pd.DataFrame({
    'region' : page.findAll('span', attrs={'class': 'tjgMj', 'data-aut-id':'item-location'}),
    'price' : page.findAll('span', attrs={'class': '_89yzn'}),
    'details': page.findAll('span', attrs={'class':'_2TVI3','data-aut-id':"itemDetails"})})
    
    d = pd.concat([d, df])

# cleaning result
d.region = d.region.apply(lambda st: st[st.find('">')+1:st.find("</span>")])
d.price = d.price.apply(lambda st: st[st.find('">')+1:st.find("</span>")])
d.details = d.price.apply(lambda st: st[st.find('">')+1:st.find("</span>")])

# remove duplicated listings
d = d.drop_duplicates()

# export to csv
d.to_csv('housing.csv')