options(digits = 3)
# machine learning model to forecast election results at the state level; include confidence interval
# can be used, for example, to find probability that PA goes blue in 2028--will obviously be less accurate over time
# data taken from MIT Election Data and Science Lab, 2017, "U.S. President 1976-2016", https://doi.org/10.7910/DVN/42MVDX, Harvard Dataverse, V5, UNF:6:Mw0hOUHAijKPTVRAe5jJvg== [fileUNF]
library(tidyverse)
setwd('C:/Users/ikeur/OneDrive/Documents/learn r/presidential_forecasting')
filename <- '1976-2016-president.csv'
read_lines(filename, n_max = 3)
file <- read.csv(filename)

# filter to only rep and dem for each state; very small inaccuracy introduced by throwing away write-ins--even if for major party candidate
# wild there isn't a better not in function
'%ni%' <- Negate('%in%')
dem <- file %>% filter(party %in% c('democrat', "democratic-farmer-labor") & candidate %ni% c('Other', '') & writein == FALSE) %>% select(year, state_po, candidatevotes, totalvotes) %>% mutate(party = 'democrat')
rep <- file %>% filter(party == 'republican' & writein == FALSE) %>% select(year, state_po, party, candidatevotes, totalvotes)

votes_simple <- data.frame(year = dem$year, state = dem$state_po, percent_dem = dem$candidatevotes / (rep$candidatevotes + dem$candidatevotes))

# # plot probability of dems winning for each state based on linear regression

# # construct numberline that contains when each state crosses 50% mark based on linear regression and color-code it based on slope

# # Monte Carlo simulation to determine proportion of runs Democrat wins at least 270 electoral votes
# # each state (except NE and ME) is all or nothing
# # likeablilty/electability/gaffs are accounted for through bias term that shifts all states by N(0, .01) amount
# # goes against theory that 95% of people vote based on party and the rest vote based on the current state of the economy but I'd feel bad not including it
# # look at what would have happened for previous elections

# # look at same analysis while including x^2 and maybe x^3 terms
