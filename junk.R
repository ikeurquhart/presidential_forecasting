# ggplot(votes_simple, aes(year, percent_dem, col = state)) + geom_line() +
#   geom_text(aes(label = state), size = 3.5) +
#   theme(legend.position = "none")
# by_state <- votes_simple %>% group_by(state) %>% summarize (perc = mean(percent_dem))

# cherry <- votes_simple %>% filter(year >= 2000)
# s = 'TX'
# name <- paste(s, 'linear_cherry_picked.jpg', sep = '')
# jpeg(filename = name)
# st <- cherry %>% filter(state == s) %>% ggplot(aes(year, percent_dem)) +
#   geom_point() +
#   geom_smooth(method = "lm") +
#   ggtitle(substr(name, 1, nchar(name) - 4)) +
#   theme(plot.title = element_text(hjust = 0.5))
# st
# dev.off()

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