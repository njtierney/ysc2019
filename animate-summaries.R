library(tidyverse)

h_cut <- tibble::tribble(
  ~country, ~year, ~height_cm, ~continent, ~type,
  "Bolivia",  1890,    163.594, "Americas", "raw",
  "Bolivia",  1900,     162.45, "Americas", "raw",
  "Bolivia",  1930,      162.5, "Americas", "raw",
  "Bolivia",  1940,      163.4, "Americas", "raw",
  "Bolivia",  1950,    162.482, "Americas", "raw",
  "Bolivia",  1960,    163.182, "Americas", "raw",
  "Bolivia",  1970,    163.886, "Americas", "raw",
  "Bolivia",  1980,    164.191, "Americas", "raw",
  "Bolivia",  1990,      168.1, "Americas", "raw",
  "Bolivia",  2000,      168.7, "Americas", "raw",
  "Ethiopia",  1860,      169.3,   "Africa", "raw",
  "Ethiopia",  1880,    167.461,   "Africa", "raw",
  "Ethiopia",  1910,    161.451,   "Africa", "raw",
  "Ethiopia",  1920,    166.636,   "Africa", "raw",
  "Ethiopia",  1930,     167.27,   "Africa", "raw",
  "Ethiopia",  1940,      168.5,   "Africa", "raw",
  "Ethiopia",  1950,    166.823,   "Africa", "raw",
  "Ethiopia",  1960,    167.512,   "Africa", "raw",
  "Ethiopia",  1970,     167.49,   "Africa", "raw",
  "Ethiopia",  1980,    167.253,   "Africa", "raw",
  "Georgia",  1840,      165.5,     "Asia", "raw",
  "Georgia",  1860,        163,     "Asia", "raw",
  "Georgia",  1890,     164.26,     "Asia", "raw",
  "Georgia",  2000,      173.2,     "Asia", "raw",
  "Paraguay",  1900,    165.615, "Americas", "raw",
  "Paraguay",  1930,    165.363, "Americas", "raw",
  "Paraguay",  1990,      172.6, "Americas", "raw",
  "Spain",  1740,      163.3,   "Europe", "raw",
  "Spain",  1750,      163.6,   "Europe", "raw",
  "Spain",  1760,      163.2,   "Europe", "raw",
  "Spain",  1770,      164.3,   "Europe", "raw",
  "Spain",  1780,      163.3,   "Europe", "raw",
  "Spain",  1830,        161,   "Europe", "raw",
  "Spain",  1840,      163.7,   "Europe", "raw",
  "Spain",  1850,      162.5,   "Europe", "raw",
  "Spain",  1860,      162.7,   "Europe", "raw",
  "Spain",  1870,      162.6,   "Europe", "raw",
  "Spain",  1880,      163.9,   "Europe", "raw",
  "Spain",  1890,        164,   "Europe", "raw",
  "Spain",  1900,      164.6,   "Europe", "raw",
  "Spain",  1910,      165.1,   "Europe", "raw",
  "Spain",  1920,      165.6,   "Europe", "raw",
  "Spain",  1930,      165.2,   "Europe", "raw",
  "Spain",  1940,      166.3,   "Europe", "raw",
  "Spain",  1950,      170.8,   "Europe", "raw",
  "Spain",  1960,      174.2,   "Europe", "raw",
  "Spain",  1970,      175.2,   "Europe", "raw",
  "Spain",  1980,      175.6,   "Europe", "raw"
)

# demonstrate these lines collapsing down onto a point
h_sum <- h_cut %>%
  group_by(country) %>%
  summarise(height_cm = mean(height_cm)) %>%
  mutate(year = max(h_cut$year),
         type = "summary")

# combined:
p <- ggplot(h_cut,
            aes(x = year,
                y = height_cm,
                colour = country)) + 
  geom_line() + 
  geom_point(data = h_sum,
             aes(x = year,
                 y = height_cm,
                 colour = country))

library(gganimate)
anim <- p + 
  transition_layers(keep_layers = FALSE) + 
  enter_grow() + 
  exit_fly(x_loc = 2000) + 
  exit_shrink() +
  ease_aes(default = "cubic-in-out")

anim
