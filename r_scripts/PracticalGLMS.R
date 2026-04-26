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


# make pos only nosema
nosPos <- bee_dat[bee_dat$Nosema_pathogen_load > 0,]

# gamma

nos_gamma <- glmer(
  Nosema_pathogen_load ~ site_code + bombus_spp + (1 | sampling_event),
  data = nosPos, family = Gamma)
Anova(nos_gamma)

nos <- glmer(
  log10_Nosema_load ~ site_code + bombus_spp + (1 | sampling_event),
  data = nosPos)
Anova(nos)





# ── Fit the mixed model ──────────────────────────────────────────────────────

# Random intercept + random slope for MEAN by PARENT
# (1 + MEAN | PARENT) means:
#   - Each parent material gets its own baseline damage probability (random intercept)
#   - Each parent material gets its own precipitation-damage slope (random slope)
# Fixed effects: the other predictors that apply globally across all parent materials

mixed_model <- glmer(
  damaged_bin ~ MEAN + MeanSlope30m + Mean_TopoConvergence_50m +
    HYDROGROUP + PercentForestedLand + Avg_Slope + K_final +
    Culvert_Count + StreamCros + Surface +
    (1 + MEAN | PARENT),
  data = model_data,
  family = binomial(link = "logit"),
  control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 100000))
)

# glmerControl settings:
#   optimizer = "bobyqa" — more robust optimizer for complex models
#   maxfun = 100000 — allows more iterations to reach convergence

summary(mixed_model)


# ── Interpret the random effects ─────────────────────────────────────────────

# Extract the random effects (intercept and slope for each PARENT level)
ranef(mixed_model)

# This shows how much each parent material deviates from the average:
#   - Positive intercept = higher baseline damage probability than average
#   - Positive MEAN slope = precipitation has a stronger effect on damage than average
#   - Negative MEAN slope = precipitation has a weaker effect than average

# Variance of random effects — how much do parent materials differ?
VarCorr(mixed_model)

# If the MEAN variance is large, the precipitation-damage relationship
# varies substantially across parent materials
# If it's near zero, precipitation affects all parent materials similarly


# ── Compare to a model without random slopes ────────────────────────────────

# Random intercept only (no random slope for MEAN)
mixed_model_intercept <- glmer(
  damaged_bin ~ MEAN + MeanSlope30m + Mean_TopoConvergence_50m +
    HYDROGROUP + PercentForestedLand + Avg_Slope + K_final +
    Culvert_Count + StreamCros + Surface +
    (1 | PARENT),
  data = model_data,
  family = binomial(link = "logit"),
  control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 100000))
)

# Likelihood ratio test: does adding the random slope improve the model?
anova(mixed_model_intercept, mixed_model)

# If significant, the effect of precipitation genuinely varies by parent material
# If not significant, precipitation affects all parent materials similarly


# ── Compare to a model with no random effects (standard GLM) ────────────────

# This tests whether accounting for parent material grouping matters at all
fixed_model <- glm(
  damaged_bin ~ MEAN + MeanSlope30m + Mean_TopoConvergence_50m +
    HYDROGROUP + PercentForestedLand + Avg_Slope + K_final +
    Culvert_Count + StreamCros + Surface + PARENT,
  data = model_data,
  family = binomial(link = "logit")
)

# Compare AIC across all three
cat("\n=== Model Comparison ===\n")
cat("Fixed GLM (PARENT as fixed effect) AIC:", round(AIC(fixed_model), 2), "\n")
cat("Mixed model (random intercept only) AIC:", round(AIC(mixed_model_intercept), 2), "\n")
cat("Mixed model (random intercept + slope) AIC:", round(AIC(mixed_model), 2), "\n")


# ── Visualize the random slopes ──────────────────────────────────────────────

# Extract random effects into a data frame
re <- as.data.frame(ranef(mixed_model)$PARENT)
re$PARENT <- rownames(re)
names(re) <- c("Intercept", "MEAN_slope", "PARENT")

# Plot: how does the precipitation effect vary by parent material?
ggplot(re, aes(x = reorder(PARENT, MEAN_slope), y = MEAN_slope)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey50") +
  geom_segment(aes(xend = PARENT, y = 0, yend = MEAN_slope),
               color = "grey60", linewidth = 0.8) +
  geom_point(aes(color = MEAN_slope > 0), size = 5) +
  scale_color_manual(values = c("TRUE" = "#B2182B", "FALSE" = "#2166AC"),
                     labels = c("Weaker than average", "Stronger than average"),
                     guide = "none") +
  coord_flip() +
  labs(title = "Effect of Precipitation on Damage by Parent Material",
       subtitle = "Random slope deviations from the population average",
       x = NULL,
       y = "Deviation in precipitation effect (log-odds scale)") +
  annotate("text", x = 1, y = max(re$MEAN_slope) * 0.7,
           label = "Red = precipitation causes\nmore damage on this material",
           color = "#B2182B", size = 4, hjust = 0) +
  annotate("text", x = 1, y = min(re$MEAN_slope) * 0.7,
           label = "Blue = precipitation causes\nless damage on this material",
           color = "#2166AC", size = 4, hjust = 1) +
  theme_minimal(base_size = 20) +
  theme(
    plot.title = element_text(size = 24, face = "bold"),
    plot.subtitle = element_text(size = 16, color = "grey50"),
    axis.text.y = element_text(size = 16),
    axis.title.x = element_text(size = 18)
  )
