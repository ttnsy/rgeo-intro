from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.chrome.options import Options

import pandas as pd
import time


list_url = []

for i in range(1,185):
    url = 'https://www.99.co/id/komplek-perumahan/Jakarta?page='+str(i)+'&per-page=12'
    list_url.append(url)

d = pd.DataFrame()

for i in list_url:
  url = i
  driver = webdriver.Chrome(executable_path="chromedriver_linux64/chromedriver")
    driver.get(url)
    time.sleep(4)
    html_source = driver.page_source
    soup = BeautifulSoup(html_source, "html.parser") 
    
    df = pd.DataFrame({
    'perum': soup.findAll('p',attrs={'class':'venue-front-title'}),
    'detail': soup.findAll('div',attrs={'class':'content_show_detail'})
    })
    
    d = pd.concat([d, df])

d.to_csv('perum.csv')


