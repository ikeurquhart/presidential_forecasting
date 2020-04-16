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
# sts <- votes_simple %>% filter(year == 1976) %>% .$state
yrs <- votes_simple %>% filter(state == 'AL') %>% .$year
# for (s in sts){
#   print(s)
#   st <- votes_simple %>% filter(state == s)
#   lin = lm(percent_dem ~ year, data = st)
#   new.dat <- data.frame(years = yrs)
#   print(lin)
#   print(class(lin))
#   stop()
#   pre <- data.frame(predict(lin, newdata = new.dat, interval = 'prediction'))
#   prob_win = 1 - pnorm(.5, pre$fit, (pre$upr - pre$fit) / 1.96)
#   print(prob_win)
# }
library(lme4)
library(lattice)
rnorm(10)
d <- data.frame(state=rep(c('NY', 'CA'), c(10, 10)),
                year=rep(1:10, 2),
                response=c(c(1, 2, 5, 4, 5, 7, 8, 9, 7, 8), c(5,6,8,12,6, 8, 7, 9, 12, 10)))
d
xyplot(response ~ year, groups=state, data=d, type='l')
fits <- lmList(response ~ year | state, data=d)
fits
class(fits)
new.dat <- data.frame(years = yrs)
# p <- predict(fits, newdata = new.dat, interval = 'prediction')
p <- predict(fits, interval = 'prediction')
summary(p)

stop()
library(dplyr)
library(broom)
yrs <- votes_simple %>% filter(state == 'AL') %>% .$year
new.dat <- data.frame(years = yrs)

# fitted_models <- votes_simple %>% group_by(state) %>% do(model = lm(percent_dem ~ year, data = .)) %>% rowwise() %>% tidy(model)
# fitted_models <- votes_simple %>% group_by(state) %>% do(model = lm(percent_dem ~ year, data = .))
# fitted_models
# class(fitted_models)
# fitted_models[1, 2]
# class(fitted_models[1, 2])
# d <- data.frame(c(1,2,3), c(7,8,9))
# d
# d[1, 2]
# class(d[1, 2])
# predicts <- predict(fitted_models[1, 2], newdata = new.dat, interval = 'prediction')
# fitted_models$model[1]
# summary(fitted_models$model[1][1])
# class(fitted_models$model[1][1])
# stop()
for (m in fitted_models$model){
  print(m)
  print(summary(m))
  print(class(m))
  predicts <- predict(m, newdata = new.dat, interval = 'prediction')
  stop()
}
predicts <- predict(fitted_models$model[51], newdata = new.dat, interval = 'prediction')
# predicts

# # construct numberline that contains when each state crosses 50% mark based on linear regression and color-code it based on slope

# # Monte Carlo simulation to determine proportion of runs Democrat wins at least 270 electoral votes
# # each state (except NE and ME) is all or nothing
# # likeablilty/electability/gaffs are accounted for through bias term that shifts all states by N(0, .01) amount
# # goes against theory that 95% of people vote based on party and the rest vote based on the current state of the economy but I'd feel bad not including it
# # look at what would have happened for previous elections

# # look at same analysis while including x^2 and maybe x^3 terms
