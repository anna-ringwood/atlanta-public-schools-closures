library(tidyverse)
library(janitor)
library(here)

i_am("CleaningCensusData.R")

dmg <- read.csv(here("Data/ACS5Y2023DP05_DemographicsAndHousingCT/ACSDP5Y2023.DP05-Data.csv"),
                na.strings = c("-", "(X)"), skip = 1, header = T) %>%
  clean_names(case = "upper_camel") %>%
  select(-contains("MarginOfError")) %>%
  select(-X) %>%
  mutate(GEOID = gsub("1400000US", "", Geography), .before = 1)

fin <- read.csv(here("Data/ACS5Y2023S2503_FinancialCharacteristicsCT/ACSST5Y2023.S2503-Data.csv"),
                na.strings = c("-", "(X)"), skip = 1, header = T) %>%
  clean_names(case = "upper_camel") %>%
  select(-contains("MarginOfError")) %>%
  select(-X) %>%
  mutate(GEOID = gsub("1400000US", "", Geography), .before = 1)

frt <- read.csv(here("Data/ACS5Y2023S1301_FertilityCT/ACSST5Y2023.S1301-Data.csv"),
                na.strings = c("-", "(X)"), skip = 1, header = T) %>%
  clean_names(case = "upper_camel") %>%
  select(-contains("MarginOfError")) %>%
  select(-X) %>%
  mutate(GEOID = gsub("1400000US", "", Geography), .before = 1)

hht <- read.csv(here("Data/ACS5Y2023B11001_HouseholdTypeCT/ACSDT5Y2023.B11001-Data.csv"),
                na.strings = c("-", "(X)"), skip = 1, header = T) %>%
  clean_names(case = "upper_camel") %>%
  select(-contains("MarginOfError")) %>%
  select(-X) %>%
  mutate(GEOID = gsub("1400000US", "", Geography), .before = 1)

inc <- read.csv(here("Data/ACS5Y2023S1903_MedianIncomePast12MonthsCT/ACSST5Y2023.S1903-Data.csv"),
                na.strings = c("-", "(X)"), skip = 1, header = T) %>%
  clean_names(case = "upper_camel") %>%
  select(-contains("MarginOfError")) %>%
  select(-X) %>%
  mutate(GEOID = gsub("1400000US", "", Geography), .before = 1)

sch <- read.csv(here("Data/ACS5Y2023B14007_SchoolEnrollmentCT/ACSDT5Y2023.B14007-Data.csv"),
                na.strings = c("-", "(X)"), skip = 1, header = T) %>%
  clean_names(case = "upper_camel") %>%
  select(-contains("MarginOfError")) %>%
  select(-X) %>%
  mutate(GEOID = gsub("1400000US", "", Geography), .before = 1)

ttw <- read.csv(here("Data/ACS5Y2023B08301_TransportationToWorkCT/ACSDT5Y2023.B08301-Data.csv"),
                na.strings = c("-", "(X)"), skip = 1, header = T) %>%
  clean_names(case = "upper_camel") %>%
  select(-contains("MarginOfError")) %>%
  select(-X) %>%
  mutate(GEOID = gsub("1400000US", "", Geography), .before = 1)

acs <- left_join(dmg, frt, by = "GEOID", suffix = c("", "_frt")) %>%
  left_join(fin, by = "GEOID", suffix = c("", "_fin")) %>%
  left_join(inc, by = "GEOID", suffix = c("", "_inc")) %>%
  left_join(hht, by = "GEOID", suffix = c("", "_hht")) %>%
  left_join(sch, by = "GEOID", suffix = c("", "_sch")) %>%
  left_join(ttw, by = "GEOID", suffix = c("", "_ttw")) %>%
  mutate(GEOID = as.numeric(GEOID))

### Filter census tracts to just those with any part in Atlanta
tracts <- read.csv("Data/AtlantaCensusTracts.csv")
final_data <- left_join(tracts, acs, by = c("GEOID_NUM" = "GEOID"))

### Export list of columns so they can easily be indicated for selection in Excel
column_names <- data.frame(names = names(final_data))
write.csv(column_names, here("Data/ListOfAllColumnNames.csv"), row.names = F)

### Now that we've indicated which columns to keep in Excel, load the indicator sheet so R can filter the appropriate columns
keep_ind <- read.csv("Data/ListOfAllColumnNamesWithKeepIndicators.csv")

data_for_gis <- final_data %>%
  select(all_of(keep_ind$names[keep_ind$keep == 1]))

write.csv(data_for_gis, "Data/ACSDataForGISJoining.csv", row.names = F, na = "")
