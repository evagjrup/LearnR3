# Code along tidy ---------------------------------------------------------

library(tidyverse)
library(NHANES)

# Looking at data
glimpse(NHANES)

# Selecting columns
select(NHANES, Age)
NHANES %>%
  select(Age)

select(NHANES, Age, Weight, BMI)
NHANES %>%
  select(Age, Weight, BMI)

select(NHANES, -HeadCirc)
NHANES %>%
  select(-HeadCirc)

select(NHANES, starts_with("BP"))
NHANES %>%
  select(starts_with("BP"))

select(NHANES, ends_with("Day"))
NHANES %>%
  select(ends_with("Day"))

select(NHANES, contains("Age"))
NHANES %>%
  select(contains("Age"))

# Create smaller NHANES datafrane
nhanes_small <- NHANES %>%
  select(
    Age, Gender, BMI, Diabetes, PhysActive, BPSysAve,
    BPDiaAve, Education
  )

# View the new data frame
nhanes_small

###############################################################
# Renaming columns
nhanes_small <- nhanes_small %>%
  rename_with(snakecase::to_snake_case)

# Renaming specific columns
nhanes_small <- nhanes_small %>%
  rename(sex = gender)

###############################################################
# Trying out the pipe
colnames(nhanes_small)

nhanes_small %>%
  colnames()

nhanes_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)

##################
# Exercise 7.8
nhanes_small %>%
  select(bp_sys_ave, education)

nhanes_small <- nhanes_small %>%
  rename(bp_sys = bp_sys_ave,
         bp_dia = bp_dia_ave)

nhanes_small %>%
  select(bp_sys)

# Rewrite
select(nhanes_small, bmi, contains("age"))

nhanes_small %>%
  select(bmi, contains("age"))

# Rewrite to be more intuitive
blood_pressure <- select(nhanes_small, starts_with("bp_"))
rename(blood_pressure, bp_systolic = bp_sys)

nhanes_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys) %>%
  rename(bp_diastolic = bp_dia)
