# machine learning model to forecast election results at the state level; include confidence interval
# can be used, for example, to find probability that PA goes blue in 2028--will obviously be less accurate over time

# construct plots for each state on predicted vote percentage and probability of dems winning for each state
# can be used, for example, to see when GA will go blue

# Monte Carlo simulation to determine proportion of runs Democrat wins at least 270 electoral votes
# each state (except NE and ME) is all or nothing
# likeablilty/electability/gaffs are accounted for through bias term that shifts all states by N(0, .01) amount
# goes against theory that 95% of people vote based on party and the rest vote based on the current state of the economy but I'd feel bad not including it

