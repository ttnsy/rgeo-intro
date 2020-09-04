# main themes -------------------------------------------------------------

# theme for map
theme_algo_map <- function(base_size = 11, base_family = "",
                         base_line_size = base_size / 22,
                         base_rect_size = base_size / 22) {
  
  theme_minimal(
    base_size = base_size, base_family = base_family,
    base_line_size = base_line_size, base_rect_size = base_rect_size
  ) +
    theme(
      plot.title = element_text(face = "bold", margin = ggplot2::margin(t = 3, b = 4)),
      plot.subtitle = element_text(margin = ggplot2::margin(t = -3.5, b = 20)),
      plot.caption = element_text(margin = ggplot2::margin(t = 5), size = 6, face = "italic"),
      panel.background = element_rect(fill = "darkslategrey"),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(colour = "white", size = .1),
      axis.text = element_blank(),
      legend.position = "top",
      legend.key.height = unit(12, "pt"),
      legend.key.width = unit(26, "pt"),
      legend.title = element_text(face = "bold"),
      legend.box.margin = ggplot2::margin(t = -20, b = -15),
      strip.background = element_rect(fill = "firebrick2"),
      strip.text = element_text(face = "bold", size = 11, color = "white"),
    )
}


# theme algo
theme_algo <- function(base_size = 11, base_family = "",
                         base_line_size = base_size / 22,
                         base_rect_size = base_size / 22) {
  
  theme_minimal(
    base_size = base_size, base_family = base_family,
    base_line_size = base_line_size, base_rect_size = base_rect_size
  ) +
    theme(
      plot.title = element_text(face = "bold", margin = ggplot2::margin(t = 15, b = 35)),
      plot.subtitle = element_text(margin = ggplot2::margin(t = -30, b = 35)),
      plot.caption = element_text(margin = ggplot2::margin(t = 35)),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(colour = "firebrick4", size = .1),
      axis.text.x = element_text(margin = ggplot2::margin(t = 10)),
      axis.title.x = element_text(margin = ggplot2::margin(t = 15)),
      axis.text.y = element_text(margin = ggplot2::margin(r = 10)),
      axis.title.y = element_text(margin = ggplot2::margin(r = 15)),
      legend.position = "top",
      legend.key.height = unit(12, "pt"),
      legend.key.width = unit(36, "pt"),
      legend.box.margin = ggplot2::margin(t = -20, b = 5),
      strip.background = element_rect(fill = "firebrick2"),
      strip.text = element_text(face = "bold", size = 11, color = "white"),
    )
  
}


# palettes ----------------------------------------------------------------

# colour palette
palette_algo <- function(colour = NULL) {
  
  pal <- c(
    "red" = "firebrick2",
    "brown" = "#bd684b",
    "lightred" = "#c79787",
    "lightgrey" = "#c6c6c6",
    "silver" = "#c3c3c2",
    "silver2" = "#bfbfbe",
    "silver3" = "#bbbbba"
  )
  
  if (!is.null(colour)) {
    
    pal <- pal[colour]
    
  }
  
  pal
  
}

ramp_palette_algo <- function(discrete = TRUE) {
  
  pal <- palette_algo()
  
  if (discrete) {
    
    colorRampPalette(pal)
    
  } else {
    
    colorRampPalette(pal[c("red", "silver")])
    
  }
  
}

# scale colour
scale_colour_algo <- function(discrete = TRUE, ...) {
  
  scale_color_algo(discrete = discrete, ...)
  
}

scale_color_algo <- function(discrete = TRUE, ...) {
  
  pal <- ramp_palette_algo(discrete = discrete)
  
  if (discrete) {
    
    discrete_scale("colour", "algo", palette = pal, ...)
    
  } else {
    
    scale_color_gradientn(colours = pal(256), ...)
    
  }
  
}

# scale fill
scale_fill_algo <- function(discrete = TRUE, ...) {
  
  pal <- ramp_palette_algo(discrete = discrete)
  
  if (discrete) {
    
    discrete_scale("fill", "algo", palette = pal, ...)
    
  } else {
    
    scale_fill_gradientn(colours = pal(256), ...)
    
  }
  
}