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

nhanes_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

nhanes_small %>%
  select(bp_sys_ave)

## Rewrite
select(nhanes_small, bmi, contains("age"))

nhanes_small %>%
  select(bmi, contains("age"))

## Rewrite to be more intuitive
blood_pressure <- select(nhanes_small, starts_with("bp_"))
rename(blood_pressure, bp_systolic = bp_sys_ave)

nhanes_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys_ave) %>%
  rename(bp_diastolic = bp_dia_ave)


#############################################
# Filtering data by row
## Only people who are NOT physically active
nhanes_small %>%
  filter(phys_active == "No")

## Only people who ARE physically active
nhanes_small %>%
  filter(phys_active != "No")

nhanes_small %>%
  filter(phys_active == "Yes")

## BMI = 25
nhanes_small %>%
  filter(bmi == 25)

## Above or equal to 25
nhanes_small %>%
  filter(bmi >= 25)

# Combining logical operators
nhanes_small %>%
  filter(bmi >= 25 & phys_active == "No")

nhanes_small %>%
  filter(bmi >= 25 | phys_active == "No")

# Sorting / arranging data
## Ascending
nhanes_small %>%
  arrange(age)

## Descending
nhanes_small %>%
  arrange(desc(age))

## Multiple columns
nhanes_small %>%
  arrange(education, age)

# Transforming data, creating new columns
## Adding columns with mutate

## Figure out age in months (change age column, not new column)
## rather than years
nhanes_small %>%
  mutate(age = age * 12)

## Adding a new column with log-transformed BMI
nhanes_small %>%
  mutate(
    age = age * 12,
    logged_bmi = log(bmi)
  )

## Add a logical condition inside a function
nhanes_small %>%
  mutate(old = if_else(age >= 30, "Yes", "No"))

####################################
# Exercise 7.12
# 1. BMI between 20 and 40 with diabetes
nhanes_small %>%
    # Format should follow: variable >= number or character
    filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

# Pipe the data into mutate function and:
nhanes_modified <- nhanes_small %>% # Specifying dataset
    mutate(
        # 2. Calculate mean arterial pressure
        mean_arterial_pressure = ((2*bp_dia_ave)+bp_sys_ave)/3,
        # 3. Create young_child variable using a condition
        young_child = if_else(age <= 6, "Yes", "No")
    )

nhanes_modified

#############################################
# Split, apply, combine method
# Creating summary statistics
nhanes_small %>%
    summarise(max_bmi = max(bmi))
## Doesn't work. Let R know to ignore missing values
## (With remove NA-function (na.rm))
nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE))

nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE),
              min_bmi = min(bmi, na.rm = TRUE))

## Split-apply-combine
nhanes_small %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE))

## Filtering by diabetes status, so NA are not included
nhanes_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE))

# When we use group_by, we group our data - however,
# it is good practice to ungroup before continuing the pipe
nhanes_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE)) %>%
    ungroup()

#############################
# Saving data
## Using the readr function
readr::write_csv(nhanes_small, here::here("data/nhanes_small.csv"))
readr::write_csv(nhanes_modified, here::here("data/nhanes_modified.csv"))



