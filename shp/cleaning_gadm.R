library(tidyverse)
library(sf)


# read original shp file -------------------------------------------------

idn3 <- st_read(dsn = "gadm36_IDN_3", layer = "gadm36_IDN_3")


# manipulation ------------------------------------------------------------

# merge kecamatan
idn3 <- idn3 %>% 
  mutate(
    NAME_3 = recode(
      NAME_3,
      "Kabayoran Lama" = "Kebayoran Lama",
      "Setia Budi" = "Setiabudi"
    )
  ) 

# separate idn3 to x & y
x <- idn3 %>% 
  filter(
    !(NAME_3 %in% c("Kebayoran Lama", "Setiabudi"))
  )


# kecamatan geometry adjustment
y <- idn3 %>% 
  filter(
    NAME_3 %in% c("Kebayoran Lama", "Setiabudi")
  ) %>% 
  mutate(
    GID_3 = recode(
      GID_3,
      "IDN.7.3.3_1" = "IDN.7.3.5_1",
      "IDN.7.3.10_1" = "IDN.7.3.11_1"
    )
  ) 

y_geom <- y %>% 
  group_by(NAME_3) %>% 
  summarise()

y <-  y %>% 
  as.data.frame() %>% 
  select(-geometry) %>% 
  left_join(y_geom, by="NAME_3") %>% 
  distinct() %>% 
  st_as_sf()

# rejoin the df
idn <- rbind(x, y) %>% 
  arrange(NAME_1)


# write as shp
st_write(idn,"idn.shp")

