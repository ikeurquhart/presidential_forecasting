options(digits = 3)
# machine learning model to forecast election results at the state level; include confidence interval
# can be used, for example, to find probability that PA goes blue in 2028--will obviously be less accurate over time
# data taken from MIT Election Data and Science Lab, 2017, "U.S. President 1976-2016", https://doi.org/10.7910/DVN/42MVDX, Harvard Dataverse, V5, UNF:6:Mw0hOUHAijKPTVRAe5jJvg== [fileUNF]
# library(tidyverse)
filename <- '1976-2016-president.csv'
read_lines(filename, n_max = 3)
file <- read.csv(filename)

# filter to only rep and dem for each state; very small inaccuracy introduced by throwing away write-ins--even if for major party candidate
# wild there isn't a better not in function
'%ni%' <- Negate('%in%')
dem <- file %>% filter(party %in% c('democrat', "democratic-farmer-labor") & candidate %ni% c('Other', '') & writein == FALSE) %>% select(year, state_po, candidatevotes, totalvotes) %>% mutate(party = 'democrat')
rep <- file %>% filter(party == 'republican' & writein == FALSE) %>% select(year, state_po, party, candidatevotes, totalvotes)

votes_simple <- data.frame(year = dem$year, state = dem$state_po, percent_dem = dem$candidatevotes / (rep$candidatevotes + dem$candidatevotes))
ggplot(votes_simple, aes(year, percent_dem, col = state)) + geom_line() + 
  geom_text(aes(label = state), size = 3.5) +
  theme(legend.position = "none")
ggplot(votes_simple, aes(year, percent_dem, col = state)) + geom_line() +
  geom_text(aes(label = state), size = 3.5, check_overlap = T) +
  theme(legend.position = "none")
# by_state <- votes_simple %>% group_by(state) %>% summarize (perc = mean(percent_dem))
# # summarize(average = mean(height), standard_deviation = sd(height))
# by_state




# # slope of regression line
# r <- cor(female_heights$mother, female_heights$daughter)
# s_y <- sd(female_heights$daughter)
# s_x <- sd(female_heights$mother)
# r * s_y/s_x
# fit <- lm(votes ~ year, data = )
# %data% %>% ggplot(aes(votes, year)) +
#   geom_point() +
#   geom_smooth(method = "lm")
# 
# fit <- falling_object %>%
#   mutate(time_sq = time^2) %>%
#   lm(observed_distance~time+time_sq, data=.)
# tidy(fit)
# augment(fit) %>%
#   ggplot() +
#   geom_point(aes(time, observed_distance)) +
#   geom_line(aes(time, .fitted), col = "blue")
# 
# # construct plots for each state on predicted vote percentage and probability of dems winning for each state
# # can be used, for example, to see when GA will go blue
# 
# # Monte Carlo simulation to determine proportion of runs Democrat wins at least 270 electoral votes
# # each state (except NE and ME) is all or nothing
# # likeablilty/electability/gaffs are accounted for through bias term that shifts all states by N(0, .01) amount
# # goes against theory that 95% of people vote based on party and the rest vote based on the current state of the economy but I'd feel bad not including it
# 
