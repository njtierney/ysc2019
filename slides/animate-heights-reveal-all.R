library(brolgar)
library(ggplot2)
library(gganimate)
anim <- ggplot(heights,
                 aes(x = year,
                     y = height_cm,
                     group = country)) + 
    geom_line() + 
    transition_manual(country, cumulative = TRUE) + 
    ease_aes("exponential")

animated <- animate(anim, 
                    fps = 24,
                    duration = 3,
                    width = 1080,
                    height = 610
                    )

anim_save(filename = here::here("slides", 
                                "anim-height-reveal-all.gif"),
          animation = animated
          )


