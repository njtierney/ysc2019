  p <- ggplot(example, 
              aes(x = year, 
                  y = height_cm)) + 
    geom_line() + 
    geom_point(colour = "red", size = 2) + 
    geom_point(aes(group = seq_along(year))) + 
    transition_reveal(year) + 
    ease_aes('cubic-in-out')
  
animated <- animate(p, 
                    fps = 24,
                    duration = 3,
                    width = 1080,
                    height = 610)

anim_save(filename = here::here("slides", 
                                "anim-example-reveal.gif"),
          animation = animated
)



