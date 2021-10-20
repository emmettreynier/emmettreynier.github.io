
# Loading packages
pacman::p_load(tigris, sf,hrbrthemes, haven, stringr, dplyr,ggplot2)

# Loading data
state_results = read.csv("state_results.csv") |>
  mutate(
    state = str_pad(state,2,"left","0")
  )


# Getting state shapes from tigris package
states_sf = 
  states(cb = TRUE) |>
  merge(
    state_results,
    by.x = "NAME",
    by.y = "StateName"
  ) |>
  filter(
    !(STATEFP %in% c("02","15"))
  )

# Plotting results
state_plot = 
  states_sf |>
  ggplot() +
  geom_sf(aes(fill = r_b3_d1, color = r_b3_d1))  +
  scale_fill_viridis_c(name = "VME", option = "magma", direction = -1, begin = 0.1) +  
  scale_color_viridis_c(name = "VME", option = "magma", direction = -1, begin = 0.1) +
  coord_sf(crs = 2163) +
  labs(
    caption = "Vertical migration externalities as a fraction of increase in state tax revenue for all states. 
    States in blue/purple have negative vertical migration externalities while states in yellow have positive vertical migration externalities."
  ) + 
  theme_ipsum()

state_plot

ggsave(
  state_plot,
  filename = "images/colas-saulnier-map.png"
)
