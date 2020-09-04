library(tidyverse)
library(magrittr)

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

write_csv(house, "data/housing_jkt.csv")
