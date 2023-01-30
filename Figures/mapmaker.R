# Map maker


# Packages

library(ggmap) #extends the plotting package ggplot2 for maps
require(tidyr) #fast and concise data manipulation packages
library(ggplot2)
library(grid)
library(ggsn)
library(sf)
library("ggspatial")


# Outline
# (1) inset map of Moorea
# (2) larger map of LTER 1


# data import
sites<-read.csv("./Figures/Map/sites.csv")
register_google(key = "AIzaSyAqUKwpoKehBV9QBxrGDSlViNYVGQo1WVE", write = TRUE)

moorea <- c(left = -149.93, bottom = -17.6, right = -149.74, top = -17.46)


#inset

moorea_map<-get_googlemap(center = c(lon = -149.831,lat = -17.531),
                          zoom = 12, 
                          style = "feature:administrative|visibility:off",
                          maptype="satellite")

moorea_map_2<-get_stamenmap(moorea,
                          zoom = 12, 
                          style = "feature:administrative|visibility:off",
                          maptype="toner-hybrid")

LTER1_inset <- c(left = -149.84530, bottom = 17.485643, right = -149.833566, top = -17.474021) # inset?

LTER1_map<-get_googlemap(center = c(lon = -149.82,lat = -17.481),
                        zoom = 14,maptype="satellite",
                        #size = c(300,300),
                        #size = 1,
                         #style = c(feature = "all", element = "labels", visibility = "on")
                        )

LTER1_map_V1<-ggmap(LTER1_map) + 
  scale_y_continuous(limits=c(-17.487, -17.471)) +
  scale_x_continuous(limits=c(-149.845, -149.805)) +
  
  

  coord_fixed(xlim = c(-149.845, -149.805), 
              ylim= c(-17.487,-17.47))



# inset map

moorea_map_inset<-ggmap(moorea_map_2) + 
  blank() +
  theme(text = element_text(size=12),
        axis.text.x = element_text(color = 'white'),
        axis.text.y = element_text(color = 'white'),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.grid.major = element_blank(), # get rid of major grid
        panel.grid.minor = element_blank(),
        panel.border = element_rect(colour = "white", fill=NA, size=2)) + # get rid of minor grid 
  annotate(geom = "rect", ymax = -17.473, ymin = -17.490, xmax = -149.845, xmin = -149.805, colour = "red",size = 1, fill = NA) +
  scale_x_continuous(breaks = c(-149.9,-149.8), expand = c(0,0)) +
  scale_y_continuous(breaks = c(-17.5,-17.6), expand = c(0,0))
  
  






#main_map<-ggmap(LTER1_map) +
main_map<-LTER1_map_V1+ 
  theme_minimal() +
  geom_point(aes(x = Long, y = Lat, color = Type), data = sites, size = 3) +
  scale_color_manual(values=c("red", "white"), labels = c('survey site','thermister')) +
  geom_text_repel(aes(x = Long, y = Lat, label = Site), data = sites,
                  family = 'Arial', 
                  size = 4, 
                  color = "yellow",
                  segment.size=0.2,
                  box.padding	= 1,
                  nudge_y = 0.0001,
                  nudge_x = 0.002) +
  theme(text = element_text(size=15),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        #legend.position = c(0.515,0.2),
        legend.position = c(0.13,0.92),
        legend.title = element_blank(),
        #legend.background = element_rect(color = "white", fill = "transparent"), 
        legend.text = element_text(color = "yellow"),
        legend.margin=margin(0.1,2,1.5,1.5),
        plot.margin = margin(0, 0.8, 0, 0, "cm"),
        panel.border = element_rect(colour = "black", 
                                    fill=NA, 
                                    size=2)) +
  ggsn::scalebar(x.min = -149.824, x.max = -149.822, 
                 y.min = -17.485, y.max = -17.486, dist_unit = "m",
                 dist = 250, transform = TRUE, 
                 model = "WGS84", height = 0.5,
                # box.color = "white", 
                 box.fill = c("yellow", "white"),
                 st.color = "white",
                 st.dist = 0.5) +
  inset(ggplotGrob(moorea_map_inset), xmin = -149.830, xmax = -149.820, ymin = -17.476, ymax = -17.471) +
  scale_x_continuous(breaks = c(-149.845,-149.832,-149.818,-149.805), expand = c(0,0)) +
  scale_y_continuous(breaks = c(-17.49,-17.48,-17.47), expand = c(0,0))+
  ggspatial::annotation_north_arrow(
    location = "tl", which_north = "true",
    style = north_arrow_orienteering(
      line_width = 1,
      line_col = "white",
      fill = c("yellow","black"),
      text_col = "white",
      text_family = "",
      text_face = NULL,
      text_size = 10
    ))

  

ggsave("Figures/Map/map.jpg", plot = main_map, width = 12, height = 8)
#ggsave("Figures/Map/map.pdf", plot = main_map, width = 12, height = 8)



## END ##
