setwd("~/pwt_greenparty")
remove(list = ls())

library(dplyr)
library(lubridate)
library(stringr)
library(tidyr)
library(labelled)
library(survey)
library(haven)


raw.manifesto <- haven::read_dta("MPDataset_MPDS2021a_stata14.dta")
manifesto <- readRDS('manifesto_data.rds')
ess_2018 <- read_csv("ess_2018.csv")
load("/Users/sn.lili/pwt_greenparty/World_Values_Survey_Wave_7_Inverted_R_v2_0.rdata")
raw.EVS <- read_sav("ZA7505_v2-0-0.sav")

raw.EVS$party_vote <- lapply(raw.EVS$E179_WVS7, get_string)

raw.EVS <- raw.EVS %>% 
  mutate(clean_partyname = str_replace(party_vote, '.*: ',  ''))

intersect(green.parties, raw.EVS$clean_partyname)
green.parties
raw.EVS$clean_partyname %>% unique()

get_string <- function(num){val_label(raw.EVS$E179_WVS7, num)}


unique(raw.EVS$clean_partyname)
unique(raw.EVS$is_green)

green.parties <- c("Greens of Andorra", "Australia Greens", "Sustainability Network", "Animal Party Cyprus",  "Ecological and Environmental Movement",  "Sustainability Network",
                   "Ecologist Green Party of Mexico", "Green Party of the United States", "Green Party", "Green Ecologist Party", "Green Alliance",
                   "Russian Ecological Party", "The Greens", "Alliance 90/The Greens", "Green Party Taiwan", 
                   "The pan-Green coalition", "Greens", "Ecological and Environmental Movement",  "We can")

raw.EVS <- raw.EVS %>% 
  mutate(is_green = ifelse(clean_partyname %in% green.parties, T, F))

summary(raw.EVS$is_green)

