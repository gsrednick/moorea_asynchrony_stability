# Script for authors - Asynchrony manuscript in preparation
# Written by G. Srednick - 02-19-2021

# Working title: Asynchronous temporal variation in coral community structure among habitats in Mo'orea, French Polynesia 
# test


# Notes ####
# N1: NAs are replaced with zeros to allow for proper rolling summation. Issues stem from changes to taxonomic ID from old classifications. This has been checked. No problems.



# packages

library(ggplot2)
library(patchwork)
library(ggpubr)
library(tidyverse)
library(vegan)
library(lmodel2)
library(tibbletime)
library(ggrepel)
library(zoo)
library(plotrix)



setwd("/Users/icarus2/Documents/Software/R/Tidy Workshop/Git/moorea_asynchrony_stability")

## Data curation ####

# Dataset -- a subset of the full community dataset.
#MCR_DSR_actual<-read.csv("MCR_DSR_data.csv")


#MCR_DSR_actual[is.na(MCR_DSR_actual)] <- 0 # replace NA's with zeros; be very careful about this. See note "N1" at line 7.



# will have to try this at finer detail -- to quadrat 
MCR_DSR_actual_fine<-read.csv("MCR_DSR_fine_data.csv")

# MCR_DSR_actual_fine[is.na(MCR_DSR_actual_fine)] <- 0 # replace NA's with zeros; be very careful about this. See note "N1" at line 7.





## Curate for just LTER 1 for plotting and 

# new DF without transect

# NEw try at fine scale #### CHECK LATER ###
MCR_DSR_actual_red<-MCR_DSR_actual_fine
#MCR_DSR_actual_red$TRANSECT <- NULL
MCR_DSR_actual_red$UNKNOWN_OR_OTHER <- NULL ### new on 3 Dec 2021 --- remove unknown

# filter for LTER 1
df_new <- MCR_DSR_actual_red %>% 
  filter(LTER == "LTER_1")

df_new[is.na(df_new)] <- 0 # replace NA's with zero. See note "N1"















 ########### MAKE SURE TO MODIFY THIS IF WE DONT GO THIS DIRECTION ******* FIX ---- CRITICAL ########
MCR_DSR_actual<-MCR_DSR_actual_fine

############



### Parameter calculation ####

## Calculates synchrony (phi) and stability (CV) measures across habitats, then for each year to compare over time

# These calculations match those from 'codyn' package, but were calculated longform to see each step

## Curate dataset for full site calculation
df_red <- MCR_DSR_actual_fine %>% 
  group_by(YEAR,LTER,HABITAT) %>% 
  dplyr::summarise_all(mean, na.rm=TRUE)


df_red$POLE <- NULL
df_red<-data.frame(df_red)

df_red$POLE <- NULL
df_red$TRANSECT <- NULL
df_red$QUADRAT <- NULL
df_red$UNKNOWN_OR_OTHER <- NULL ### new on 3 Dec 2021 --- remove unknown



# Make rowsums (i.e., tally up percent cover)
DSR_sums <- df_red %>% 
  dplyr::mutate(sum = dplyr::select(., 4:22) %>% 
                  rowSums(na.rm = TRUE))




# Filtered to LTER 1
LTER1_sums <- DSR_sums %>% 
  filter(LTER == "LTER_1", YEAR > 2005) # No back-reef data for 2005






# summarize to single replicate per year; means

LTER1_summarized<-LTER1_sums %>% 
  group_by(YEAR) %>% 
  dplyr::summarise_all(mean,na.rm = TRUE)


## Step 1: calculate mean for each species, replicate, and total

DSR_mean_across<-rollapply(LTER1_sums[c(4:23)], 8, mean, by=4, fill=NA,na.rm = TRUE) # uses rollmean
DSR_mean_across<-cbind(LTER1_sums[c(1:3)],DSR_mean_across)



# Step 2: calculate variance for each species, replicate, and total

DSR_var_across<-rollapply(LTER1_sums[c(4:23)], 8, var, by=4, fill=NA,na.rm = TRUE) # uses rollmean
DSR_var_across<-cbind(LTER1_sums[c(1:3)],DSR_var_across)



# Reduce mean and variance down to annual measure

DSR_mean_across_2<-DSR_mean_across[rowSums(is.na(DSR_mean_across[c(4:23)])) != ncol(DSR_mean_across[c(4:23)]), ]
DSR_var_across_2<-DSR_var_across[rowSums(is.na(DSR_var_across[c(4:23)])) != ncol(DSR_var_across[c(4:23)]), ]



## Synchrony calculations start here:

# Step 3: sum all square-rooted variances (rho) across species

DSR_sqr_var_across<-sqrt(DSR_var_across_2[c(4:23)]) # square-root the variances for rho

DSR_rho_across <- DSR_sqr_var_across %>% 
  dplyr::mutate(rho = dplyr::select(., 1:19) %>% 
                  rowSums(na.rm = FALSE)) # Sum square-rooted variances

DSR_rho_across_V2<-DSR_rho_across$rho^2 # square the summed square-rooted variances for rho






# Step 4: divide community variance by summed rho

DSR_com_variance_across <- DSR_var_across_2$sum 

phi_across <- data.frame(DSR_com_variance_across/DSR_rho_across_V2)


# Here is finished product for synchrony 

DSR_phi_across<-dplyr::bind_cols(DSR_mean_across_2[c(1:2)],phi_across) # rename levels

names(DSR_phi_across)<-c("YEAR","LTER","phi") # rename columns

DSR_phi_across # Check values






## Community variability (stability) calculations start here:

# Get mean abundance 
sample_mean_across<-DSR_mean_across_2[-c(1:3,23)]

# Step 2 (left side of equation)
stnd_mean_across<-sample_mean_across/DSR_mean_across_2$sum




# NA omits for simplicity in 2005
stnd_mean_across_NA<-na.omit(stnd_mean_across) # 281 rows
var_across_NA<-na.omit(DSR_var_across_2[c(4:22)]) # 281 rows
sample_mean_across_NA<-na.omit(sample_mean_across)



var_time_across_label<-(DSR_var_across_2[c(1:3)])  # label 
#var_time_across_label<-var_time_across_label[-1]

# Step 3 (right side of equation)
stnd_var_across<-sqrt(var_across_NA)/sample_mean_across_NA

# Step 4
CV_across <- stnd_mean_across_NA * stnd_var_across

# sum CV values across species
CV_com_across <- CV_across %>% 
  dplyr::mutate(ALL = dplyr::select(., 1:19) %>% 
                  rowSums(na.rm = TRUE))

# final CV calculation
phi_across_short<-na.omit(phi_across) # corrected

CV_across_main<-sqrt(phi_across_short)*(CV_com_across$ALL) 

CV_across_final<-dplyr::bind_cols(var_time_across_label,CV_across_main) # this was corrected to have the right factor levels line up

names(CV_across_final)<-c("YEAR","LTER","HABITAT","CV") # rename columns







# Bind synchrony and community variability (CV aka stability)
stability_across<-merge(DSR_phi_across,CV_across_final) # finished product







### Analyses ####

## PERMANOVA for spatiotemporal variation in the coral community

env<-df_new[(1:6)]
coral<-df_new[(7:25)]
coral_dummy<-df_new[(7:25)]+1


# This permanova takes a bit of time. Patience...
main_perm<-adonis2(coral_dummy ~ YEAR * HABITAT, data = env, method = "bray", permutations = 999)




##  Regression between stability (CV) and synchrony (phi)

# this is model II regression; we use major axis (MA) regression 
phi_regression_II <- lmodel2(CV ~ phi, data=stability_across, "relative", "relative", 999)
phi_cor<-cor(stability_across$CV,stability_across$phi, method = "pearson")





### Figures ####
# Figure 1 - map ####

source("./Figures/mapmaker.R")

main_map





## Figure 2  -- Changes over time in coral cover and community structure across habitats ####

# Data organize for Figure 2A-D
# common species over time


# QUADRAT SCALE
df_summed <- df_new %>% 
  dplyr::mutate(sum = dplyr::select(., 7:25) %>% 
                  rowSums(na.rm = TRUE))

df_summed_common<-df_summed %>% 
  dplyr::select(YEAR,LTER,HABITAT,TRANSECT,POLE,QUADRAT,POCILLOPORA,ACROPORA,PORITES,MONTIPORA,sum)

df_reduced <- df_summed_common %>% 
  group_by(LTER,HABITAT,YEAR) %>% 
  dplyr::summarise_all(mean)

# make long for plotting
df_long<-df_summed_common %>% 
  tidyr::pivot_longer(cols = POCILLOPORA:sum, names_to = "species", values_to = "cover")

df_long$HABITAT <- factor(df_long$HABITAT , levels = c("Fringe","Backreef","10m","17m"))








## panels A-D - dotplot of common coral species

spp_dot<-ggplot(df_long, aes(x= as.numeric(YEAR), y = cover, group = species)) +
  stat_summary(fun.data = mean_se, 
               geom = "pointrange") +      
  stat_summary(aes(fill = species), #color = "black", 
               geom = "point",
               pch=21,
               fun = "mean", 
               size = 4) +
  stat_summary(geom = "line", 
               aes(fill = species), 
               fun = "mean") +
  theme_bw() +
  labs(x = "Year", y = "% cover") +
  scale_fill_manual(labels = c(expression(italic("Acropora spp.")), 
                               expression(italic("Montipora spp.")), 
                               expression(italic("Pocillopora spp.")), 
                               expression(italic("Porites spp.")), 
                               "all spp."), 
                    values = c("red", "blue", "black", "yellow", "white")) +
  scale_x_continuous(n.breaks=10) +
  theme(text = element_text(size=12), 
        axis.text.x = element_text(angle=45,hjust = 1),
        legend.position = c(0.9, 0.7),
        legend.title = element_blank(),
        legend.background = element_blank(),
        strip.background = element_blank(),
        strip.text.x = element_blank(),
        legend.text.align = 0,
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  facet_wrap(~ HABITAT, nrow = 1)









## panels E-H - MDS of total coral community

# data prep for MDS

df_10 <- df_new %>% filter(HABITAT == "10m") %>% dplyr::group_by(YEAR) %>% dplyr::summarise_all(mean)
df_10$HABITAT <- "10m"
df_10$POLE <- NULL
#df_10$LTER <- Site

df_17 <- df_new %>% filter(HABITAT == "17m") %>% dplyr::group_by(YEAR) %>% dplyr::summarise_all(mean)
df_17$HABITAT <- "17m"
df_17$POLE <- NULL
#df_17$LTER <- Site

df_lagoon <- df_new %>% filter(HABITAT == "Backreef") %>% dplyr::group_by(YEAR) %>% dplyr::summarise_all(mean)
df_lagoon$HABITAT <- "Backreef"
df_lagoon$POLE <- NULL
#df_lagoon$LTER <- Site

df_fringe <- df_new %>% filter(HABITAT == "Fringe") %>% dplyr::group_by(YEAR) %>% dplyr::summarise_all(mean)
df_fringe$HABITAT <- "Fringe"
df_fringe$POLE <- NULL
#df_fringe$LTER <- Site





# make matrices 
# 10m 
com_10<-df_10[c(6:24)]
env_10<-df_10[c(1:3)]
com_10_mds <- metaMDS(comm = com_10, distance = "bray", trace = FALSE, autotransform = FALSE, na.rm = FALSE)
com_10_mds$stress # 0.003945023
com_10_mds_points<-data.frame(com_10_mds$points)
mds_10<-merge(env_10,com_10_mds_points, by="row.names", all.x=TRUE)

mds_10_matrix <- vegdist(com_10, distance = "bray", trace = FALSE, autotransform = FALSE)
mds_10_matrix<-as.matrix(mds_10_matrix,labels=TRUE)

rownames(mds_10_matrix)<-env_10$YEAR
colnames(mds_10_matrix)<-env_10$YEAR

# 17m
com_17<-df_17[c(6:24)]
env_17<-df_17[c(1:3)]
com_17_mds <- metaMDS(comm = com_17, distance = "bray", trace = FALSE, autotransform = FALSE)
com_17_mds$stress # 0.02312376
com_17_mds_points<-data.frame(com_17_mds$points)
mds_17<-merge(env_17,com_17_mds_points, by="row.names", all.x=TRUE)

mds_17_matrix <- vegdist(com_17, distance = "bray", trace = FALSE, autotransform = FALSE)
mds_17_matrix<-as.matrix(mds_17_matrix,labels=TRUE)

rownames(mds_17_matrix)<-env_17$YEAR
colnames(mds_17_matrix)<-env_17$YEAR



# Lagoon
com_BR<-df_lagoon[c(6:24)]
env_BR<-df_lagoon[c(1:3)]
com_BR_mds <- metaMDS(comm = com_BR, distance = "bray", trace = FALSE, autotransform = FALSE)
com_BR_mds$stress # 0.008078968
com_BR_mds_points<-data.frame(com_BR_mds$points)
mds_BR<-merge(env_BR,com_BR_mds_points, by="row.names", all.x=TRUE)

mds_BR_matrix <- vegdist(com_BR, distance = "bray", trace = FALSE, autotransform = FALSE)
mds_BR_matrix<-as.matrix(mds_BR_matrix,labels=TRUE)

rownames(mds_BR_matrix)<-env_BR$YEAR
colnames(mds_BR_matrix)<-env_BR$YEAR


# Fringe
com_FR<-df_fringe[c(6:24)]
env_FR<-df_fringe[c(1:3)]
com_FR_mds <- metaMDS(comm = com_FR, distance = "bray", trace = FALSE, autotransform = FALSE)
com_FR_mds$stress # 9.870811e-05
com_FR_mds_points<-data.frame(com_FR_mds$points)
main_FR<-merge(env_FR,com_FR_mds_points, by="row.names", all.x=TRUE)

mds_FR_matrix <- vegdist(com_FR, distance = "bray", trace = FALSE, autotransform = FALSE)
mds_FR_matrix<-as.matrix(mds_FR_matrix,labels=TRUE)

rownames(mds_FR_matrix)<-env_FR$YEAR
colnames(mds_FR_matrix)<-env_FR$YEAR

## Join all habitats together
main_mds<-bind_rows(mds_17,mds_10,mds_BR,main_FR)


# Add total coral cover for size of MDS objects
LTER1_cover<- DSR_sums %>% 
  filter(LTER == "LTER_1")

mds_ready<-merge(main_mds,LTER1_cover, by=c("YEAR","HABITAT"))

mds_ready$HABITAT <- factor(mds_ready$HABITAT , levels = c("Fringe","Backreef","10m","17m"))



# plot
habitat_mds<-ggplot(mds_ready[order(mds_ready$YEAR),], aes(MDS1, MDS2,label = YEAR)) +
  geom_point(aes(size = sum), pch = 21, fill ="grey", color = "black", stroke = 1) +
  scale_size_continuous(range = c(0.5, 15)) +
  geom_path(color = "black") +
  theme_bw() +
  labs(size = "Coral cover (%)") +
  theme(text = element_text(size = 12),
        strip.background = element_blank(),
        strip.text.x = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  geom_text_repel(data = subset(mds_ready, YEAR %in% c(2005,2007,2009,2011,2013,2015,2017,2019)),
                  box.padding = 0.9, max.overlaps = Inf, 
                  color = "black") +
  facet_grid(cols = vars(HABITAT)) +
  scale_y_continuous(limits = c(-1, 0.8)) +
  scale_x_continuous(limits = c(-2, 3.5))




# combine panels
coral_change_plot_F2 <- spp_dot + habitat_mds +  plot_layout(ncol = 1)

# print
ggsave("./Figures/Figure_2.pdf", plot = coral_change_plot_F2, width = 12, height = 6.5)




# Figure 3 ####

# Panel A -- summed coral cover across habitats
unique(df_long$YEAR)

across_dot<-ggplot(df_long, aes(x= as.numeric(YEAR), y = cover, fill = species)) +
  stat_summary(fun.data = mean_se, 
               geom = "pointrange") +      
  stat_summary(aes(fill = species), #color = "black", 
               geom = "point",
               fun = "mean",
               pch = 21,
               size = 4) +
  stat_summary(geom = "line", 
               aes(fill = species), 
               fun = "mean") +
  theme_bw() +
  scale_fill_manual(labels = c(expression(italic("Acropora spp.")), expression(italic("Montipora spp.")), expression(italic("Pocillopora spp.")), expression(italic("Porites spp.")), "all spp."), values = c("red", "blue", "black", "yellow", "white")) +
  labs(y = "% cover", x = "Year") +
  scale_x_continuous(n.breaks=11,limits = c(2006, 2019)) +
  theme(text = element_text(size=12),
        axis.title.x = element_blank(),
        legend.position = c(0.5, 0.8),
        legend.title = element_blank(),
        axis.text.x = element_blank(), #element_text(angle=45,hjust = 1),
        #legend.background = element_blank(),
        legend.text.align = 0,
        legend.background = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())



# Panel B -- synchrony (phi) and stability (CV) over time

# make long
stability_across_long<-stability_across %>% 
  tidyr::pivot_longer(cols = c(phi,CV), names_to = "measures", values_to = "value")

unique(stability_across_long$YEAR)
stability_across_long$year_plot<-stability_across_long$YEAR + 1
# plot
stab_long_dot <- ggplot(stability_across_long, aes(x= year_plot, y = value, color = measures)) +
  geom_point(size = 4) +
  geom_path() +
  theme_bw() +
  labs(x = "Year", y = "value") +
  theme(text = element_text(size=12), 
        axis.text.x = element_text(angle=45,hjust = 1),
   #     axis.title.x = element_blank(),
        legend.position = c(0.85, 0.25),
        legend.title = element_blank(),
        legend.background = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  scale_x_continuous(n.breaks=11,limits = c(2006, 2019)) 


# combine panels A and B
coral_across_plot_F3 <- across_dot + stab_long_dot + plot_layout(ncol = 1) + plot_annotation(tag_level = 'A')


# print
ggsave("./Figures/Figure_3.jpg", plot = coral_across_plot_F3, width = 4.5, height = 7.6)

ggsave("./Figures/Figure_3.pdf", plot = coral_across_plot_F3, width = 4.5, height = 7.6)








# Figure 4 - regression between stability and synchrony ####


stab_regression<-ggplot(stability_across, aes(x= phi, y = CV)) +
  geom_point(size = 3) +
  stat_smooth(method = "lm", se = FALSE, color = "black") +
  labs(x = "phi", y = "CV") +
  theme_bw() +
  scale_x_continuous(limits = c(0, 1)) +
  theme(text = element_text(size=12)) +
  ylim(0,1.3) +
  theme(legend.background = element_blank(),
                panel.grid.major = element_blank(), 
                panel.grid.minor = element_blank())



# annotate
phi_CV_F4<-stab_regression +
  annotate("text", x=0.8, y=0.33,
           label = deparse(bquote(r == "0.97, p = 0.01")),
           parse = TRUE)

#print
ggsave("./Figures/Figure_4.jpg", plot = phi_CV_F4, width = 4.5, height = 4)













#### Environmental figure ####

# bring in data 

DTR_avg<-read.csv("/Users/icarus2/Documents/Software/R/Tidy Workshop/Git/moorea_asynchrony_stability/Davis_env/env_csvs/DTR_avg.csv")
DTR_spwn<-read.csv("/Users/icarus2/Documents/Software/R/Tidy Workshop/Git/moorea_asynchrony_stability/Davis_env/env_csvs/DTR_spwn.csv")
waves<-read.csv("/Users/icarus2/Documents/Software/R/Tidy Workshop/Git/moorea_asynchrony_stability/Davis_env/env_csvs/waves.csv")

# tidy
DTR_spwn_long<-DTR_spwn %>%
  tidyr::pivot_longer(cols = Fringe:X17m, names_to = "sites", values_to = "DTR_spawn")


# remove 2011 from 'waves' -- not enough data for that year
waves<-waves %>% filter(!Year == "2011")

# remove 2019 from 'DTR' -- not enough data for that year
DTR_spwn_long<-DTR_spwn_long %>% filter(!Year == "2019")



# Panel A - temperature
env_A<-ggplot(data = DTR_spwn_long, aes(x=Year, y = DTR_spawn, fill = sites, group = sites)) +
  geom_point(pch = 21, color = "black", size = 4, stroke = .4) +
  geom_line() +
  theme_bw() +
  scale_fill_manual(labels = c("Fringe","Lagoon","10m","17m"),values = c("red", "blue", "black", "grey", "white")) +
  labs(y = "DTR (Sept - Dec)") +
  theme(text = element_text(size=12), 
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        legend.title = element_blank(),
        #legend.background = element_blank(),
        legend.position="top",
        legend.spacing.x = unit(0.1, "cm"),
        legend.spacing.y = unit(0.2, "cm"),
        plot.margin = unit(c(.01,.01,.01,.01), "cm"),
        legend.background = element_blank(),
        panel.grid.major = element_blank(), 
       panel.grid.minor = element_blank()) +
  scale_x_continuous(n.breaks=15)

  



# Panel b - waves
env_B<-ggplot(data = waves, aes(x=Year, y = Pavg_spn)) +
  geom_point(pch = 21, color = "black", size = 4, stroke = .8) +
  geom_line() +
  labs(y = expression(paste("mean kW m"^-1))) +
  theme_bw() +
  theme(text = element_text(size=12), 
        axis.text.x = element_text(angle=45,hjust = 1),
        #     axis.title.x = element_blank(),
        legend.position = c(0.85, 0.25),
        legend.title = element_blank(),
        #legend.background = element_blank(),
        plot.margin = unit(c(.01,.01,.01,.01), "cm"),
        legend.background = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  ylim(2000,5500) +
  scale_x_continuous(n.breaks=15)
  


# bring together 

env_F5 <- env_A + env_B + plot_layout(ncol = 1) + plot_annotation(tag_level = 'A')


ggsave("./Figures/Figure_5.jpg", plot = env_F5, width = 5.5, height = 7)




# Supplemental assessments ####

# results summary stats
MCR_DSR_actual_fine_cover <- MCR_DSR_actual_fine
MCR_DSR_actual_fine$UNKNOWN_OR_OTHER <- NULL ### Remove unknown
# mean cover per habitat - for each year 

means<-MCR_DSR_actual_fine %>% 
  filter(LTER == "LTER_1") %>%
  group_by(HABITAT,YEAR) %>%
  summarize_all(mean,na.rm=TRUE)

means <- as.data.frame(means) %>% dplyr::mutate(sum = dplyr::select(., 7:25) %>% rowSums(na.rm = TRUE))


se<-MCR_DSR_actual_fine %>% 
  filter(LTER == "LTER_1") %>%
  group_by(HABITAT,YEAR) %>%
  summarize_all(std.error,na.rm=TRUE)


se <- as.data.frame(se) %>% dplyr::mutate(sum = dplyr::select(., 7:25) %>% rowSums(na.rm = TRUE))




## END ##
