#Sprint
SPR <- readRDS("sprint.rds")
CURRENT_RATING_SPR <- readRDS("current_rating_spr.rds")

#Distance
DST <- readRDS("distance.rds")
CURRENT_RATING_DST <- readRDS("current_rating_dst.rds")

P <- 1.25
PROVISIONAL_N <- 6L
SEASON_SHRINK <- 2/3

K_DST_MAX <- c("Interval" = 47,
                "Mass" = 40,
                "Pursuit" = 40,
                "Handicap" = 35,
                "Pursuit Break" = 40)
K_DST_MIN <- c("Interval" = 17,
               "Mass" = 10,
               "Pursuit" = 10,
               "Handicap" = 5,
               "Pursuit Break" = 10)

K_SPR_MIN <- 17
K_SPR_MAX <- 47