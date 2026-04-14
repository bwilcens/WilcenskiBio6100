# Practical GLMS

# 4/14/2026

library(tidyverse)
library(lubridate)
library(lme4)
library(car)

bee_dat <- read_csv("Data/Burnham_field_data_pathogens_wide.csv")

bee_dat <- bee_dat %>%
  mutate(
    sampling_date = mdy(sampling_date),
    site_code = factor(site_code),
    field_id = factor(field_id),
    bee_caste = factor(bee_caste),
    bombus_spp = factor(bombus_spp),
    host_plant = factor(host_plant),
    sampling_event = factor(sampling_event),
    sampling_event_num = as.numeric(as.character(sampling_event)),
    log10_BQCV_load = log10(BQCV_pathogen_load + 1),
    log10_DWV_load = log10(DWV_pathogen_load + 1),
    log10_Nosema_load = log10(Nosema_pathogen_load + 1)
  )

glimpse(bee_dat)

# prevalence = binary (boolean)
# load = magnitude (numerical)

# filter for only pos:
df_filtered <- bee_dat[bee_dat$log10_DWV_load > 0 & bee_dat$log10_BQCV_load > 0, ]

hist(df_filtered$log10_BQCV_load)
hist(df_filtered$log10_DWV_load) #show that the data is normally distributed

# continuous y cont x.

m_cont_cont <- lm(data = df_filtered, log10_DWV_load~log10_BQCV_load)
summary(m_cont_cont)

qplot(
  x = log10_BQCV_load,
  y = log10_DWV_load,
  data = df_filtered) +
geom_smooth(method = "lm", se = TRUE)



# cont y , cat x 

m_cont_cat<-lm(data=df_filtered, log10_BQCV_load~bombus_spp)
summary(m_cont_cat)


# cat y cont x

m_cat_cont <- glm(data = bee_dat, DWV_pathogen_binary~log10_BQCV_load, family = binomial(link = "logit")) #had to use glm bc of continuous y

summary(m_cat_cont)

# AIC - a score for the amount of varience the model has (not comparable across models and/or data)

# cat y cat x

m_cat_cat <- glm(data = bee_dat, DWV_pathogen_binary~bee_caste, family = binomial(link = "logit")) #had to use glm bc of continuous y
summary(m_cat_cat)



# testing for significance
# car package (companion of applied regression)

# build soem models 

bin_mod <- glm(data=bee_dat, DWV_pathogen_binary ~ bombus_spp * sampling_event+host_plant, family = binomial(link = "logit"))

guas_mod <- lm(data= bee_dat, log10_Nosema_load ~ sampling_event*host_plant) #assumes gausian
summary(bin_mod)
summary(guas_mod)

# using car package for sig

Anova(bin_mod) # analysis of deviance table in output 
Anova(guas_mod) # cont model (presents an ANOVA table in output)

#likelihood ratio test 
m_dwv_null <- lm(data = df_filtered, log10_DWV_load ~ 1) #null model - should have no predictive power
m_dwv_full <- lm(data = df_filtered, log10_DWV_load ~ sampling_event + host_plant) #model of interest (should be predictive)

anova(m_dwv_null, m_dwv_full, test = "LRT") #results in highly predictive result for the full model 


#### comparing reduced model to the full model 

m_dwv_reduced <- lm(data = df_filtered, log10_DWV_load ~ sampling_event)

anova(m_dwv_reduced, m_dwv_full, test = "LRT")


# lme4 package (mixed model extension of linear model)

g_bqcv_site <- lmer(
  log10_BQCV_load ~ bombus_spp + sampling_event + (1 | site_code), data = df_filtered) # control for variance from site code, day

Anova(g_bqcv_site)





