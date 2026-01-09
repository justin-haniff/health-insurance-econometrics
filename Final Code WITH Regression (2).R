library(ipumsr)
library(dplyr)
library(survey)

# Load dataset
ddi <- read_ipums_ddi("C:/Users/Justi/Documents/nhis_00002.xml.xml")
nhis <- read_ipums_micro(ddi)

# Keep sample adults
nhis_adult <- nhis %>%
  filter(ASTATFLG == 1) %>%
  mutate(
    uninsured = case_when(
      HINOTCOVE == 1 ~ 0,
      HINOTCOVE == 2 ~ 1,
      TRUE ~ NA_real_
    ),
    private_ins = case_when(
      HIPRIVATEE %in% c(2, 3) ~ 1,
      HIPRIVATEE == 1 ~ 0,
      TRUE ~ NA_real_
    ),
    delay_cost = case_when(
      DELAYCOST == 1 ~ 0,
      DELAYCOST == 2 ~ 1,
      TRUE ~ NA_real_
    ),
    reason_unemp = case_when(
      HINOUNEMPR == 2 ~ 1,
      HINOUNEMPR == 1 ~ 0,
      TRUE ~ NA_real_
    ),
    reason_cost = case_when(
      HINOCOSTR == 2 ~ 1,
      HINOCOSTR == 1 ~ 0,
      TRUE ~ NA_real_
    ),
    reason_miss_deadline = case_when(
      HINOMISS == 2 ~ 1,
      HINOMISS == 1 ~ 0,
      TRUE ~ NA_real_
    ),
    reason_cost_increase = case_when(
      HISTOP23 == 2 ~ 1,
      HISTOP23 == 1 ~ 0,
      TRUE ~ NA_real_
    ),
    reason_stop_deadline = case_when(
      HISTOP24 == 2 ~ 1,
      HISTOP24 == 1 ~ 0,
      TRUE ~ NA_real_
    )
  )

# Survey design
des <- svydesign(
  id = ~PSU,
  strata = ~STRATA,
  weights = ~SAMPWEIGHT,
  nest = TRUE,
  data = nhis_adult
)

# Estimates
svymean(~uninsured, des, na.rm = TRUE)
svymean(~delay_cost, des, na.rm = TRUE)

svyby(~delay_cost, ~uninsured, des, svymean, na.rm = TRUE)

des_uninsured <- subset(des, uninsured == 1)

svymean(~reason_unemp + reason_cost + reason_miss_deadline +
          reason_cost_increase + reason_stop_deadline,
        design = des_uninsured,
        na.rm = TRUE)

nhis_adult <- nhis_adult %>%
  mutate(
    underinsured = case_when(
      uninsured == 0 & delay_cost == 1 ~ 1,
      uninsured == 0 & delay_cost == 0 ~ 0,
      TRUE ~ NA_real_
    )
  )

des <- update(des, underinsured = nhis_adult$underinsured)
svymean(~underinsured, des, na.rm = TRUE)
des <- svydesign(
  +     id = ~PSU,
  +     strata = ~STRATA,
  +     weights = ~SAMPWEIGHT,
  +     nest = TRUE,
  +     data = nhis_adult
  + )
> 
  > model_delay <- svyglm(
    +     delay_cost ~ uninsured,
    +     design = des,
    +     family = quasibinomial()
    + )
> 
  > summary(model_delay)



