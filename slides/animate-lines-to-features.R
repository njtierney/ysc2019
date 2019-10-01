library(brolgar)
library(tidyverse)
library(gganimate)
set.seed(2019-09-30-0012)
heights_sub <- sample_n_keys(heights, size = 20)

h_sum <- heights_sub %>%
  as_tibble() %>% 
  group_by(country) %>%
  summarise(height_cm = max(height_cm)) %>%
  mutate(year = max(heights_sub$year),
         type = "summary")

# combined:
p <- ggplot(heights_sub,
            aes(x = year,
                y = height_cm,
                group = country)) + 
  geom_line() + 
  geom_point(data = h_sum,
             aes(x = year,
                 y = height_cm,
                 group = country)) 

p

heights_sub_flat <- heights_sub %>%
  as_tibble() %>%
  group_by(country) %>% 
  mutate(height_cm = max(height_cm))

heights_sub_flat_combine <- bind_rows(
  regular = as_tibble(heights_sub),
  flat = heights_sub_flat,
  .id = "state"
) %>%
  mutate(state = factor(state, levels = c("regular", "flat")))

anim_flat <- 
ggplot(heights_sub_flat_combine,
       aes(x = year,
           y = height_cm,
           group = country)) + 
  geom_line() + 
  transition_states(state,
                    wrap = FALSE,
                    )

heights_sub_flat_point <- heights_sub_flat %>%
  filter(year == max(year))

heights_sub_flat_combine_point <- bind_rows(
  flat = heights_sub_flat,
  point = heights_sub_flat_point,
  .id = "state"
) 

p <- ggplot(heights_sub_flat,
       aes(x = year,
           y = height_cm,
           group = country)) + 
  geom_line() +
  geom_point(data = heights_sub_flat_point,
             aes(x = year,
                 y = height_cm)) +
  lims(y = range(heights_sub$height_cm))

anim <- p + 
  transition_layers(keep_layers = FALSE,
                    from_blank = FALSE) +
  exit_shrink() +
  ease_aes("cubic-in-out") +
  exit_fly(x_loc = 2000) 

part_one <- animate(anim_flat, fps = 24, duration = 3)
part_two <- animate(anim, fps = 24, duration = 3)

library(magick)
part_one_m <- image_read(part_one)
part_two_m <- image_read(part_two)

new_gif <- c(part_one_m, part_two_m)

new_gif
image_write_gif(new_gif, path = "lines-to-points.gif")
