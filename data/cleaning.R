library(tidyverse)
library(magrittr)
library(qdapRegex)
library(tidygeocoder)
library(glue)

# for perum data ----------------------------------------------------------

# read and clean
perum <- read_csv("data/scraping/perum.csv") %>% 
  select(-X1)

perum %<>% 
  mutate(
    perum = ex_between(perum, '<p class=\"venue-front-title\">','</p>\n'),
    kota = ex_between(detail, 'class=\"fa fa-map-marker\"></span>\n','<br/>\n<span class=\"fa fa-arrow-up\">',
                      '<br/>\n<span class=\"fa fa-arrow-up\">')
  ) %>% 
  select(-detail) %>% 
  mutate(
    kota = str_remove(kota, ",.*")
  ) %>% 
  distinct()%>%
  rename(perumahan = perum)

# get long-lat
mylist <- split(perum, perum$kota)

for (i in 1:length(mylist)){
  mylist[[i]] %<>% 
  mutate(perum_kota = glue("{perumahan}, {kota}")) %>% 
  geocode(perum_kota, method = 'osm', lat = latitude , long = longitude, full_results=TRUE)
}

perum <- bind_rows(mylist) %>% 
  drop_na(latitude, longitude) %>% 
  select(perumahan, kota, latitude, longitude)

perum <- perum %>% 
  filter(!(perumahan %in% c('Marcella Residence','The Rose House',
                            'serpong lagoon','Casa Jardin',
                            'Camden House')))

# write as csv
write_csv(perum, "data/perumahan.csv")

# for housing data --------------------------------------------------------

house <- read_csv("data/scraping/housing.csv") %>% 
  select(-X1)

house %<>% 
  mutate(kota = str_extract(region, ',.*$'),
         kota = str_replace(kota, ", ",''),
         region = str_remove(region, ',.*$')) %>% 
  rename(kecamatan = region) %>% 
  mutate(id = row_number()) %>% 
  select(id,kota, kecamatan, everything()) %>%
  separate_rows(., details, sep = " - ") %>% 
  mutate(names = str_extract(details, ' .*$'),
         names = str_remove(names, ' ')) %>% 
  pivot_wider(names_from = names, values_from = details) %>% 
  mutate(price = str_remove(price,"[^\\d.]+"),
         price = str_remove(price, "[[:punct:]]+"),
         price = str_remove(price, "[[:punct:]]+"),
         price = str_remove(price, "[[:punct:]]+"),
         KT = str_extract(KT, "\\d+"),
         KM = str_extract(KM, "\\d+"),
         m2 = str_extract(m2, "\\d+")) %>% 
  mutate(
    kota = recode(
      kota, 
      "Tangerang Kota" = "Kota Tangerang",
      "Tangerang Selatan Kota" = "Tangerang Selatan",
      "Tangerang Kab." = "Tangerang",
      "Depok Kota" = "Depok",
      "Bekasi Kab." = "Bekasi",
      "Bekasi Kota" = "Kota Bekasi"
    ),
    kecamatan = recode(
      kecamatan,
      "Kabayoran Lama" = "Kebayoran Lama",
      "Grogol Petamburan" = "Grogolpetamburan",
      "Tanah Abang" = "Tanahabang",
      "Kramat Jati" = "Kramatjati",
      "Setia Budi" = "Setiabudi",
      "Pasar Rebo" = "Pasarrebo",
      "Pulo Gadung" = "Pulogadung",
      "Pondok Gede" = "Pondokgede",
      "Jati Sampurna" = "Jatisampurna",
      "Taman Sari" = "Tamansari",
      "Pondok Melati" = "Pondokmelati",
      "Kebon Jeruk" = "Kebonjeruk"
    )
  ) %>% 
  filter(kota != "Bangka Selatan Kab.")

house %<>% 
  mutate_at(c("price","KT","KM","m2"), as.numeric) %>% 
  rename(harga = price) %>% 
  filter(harga < 50000000000 & harga > 5e6) %>% 
  filter(m2 >= 18)

# write as csv

write_csv(house, "data/listings.csv")
