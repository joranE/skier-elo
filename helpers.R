ath_ranking <- function(s,dt,ratings,prov = 6){
  if (s > max(ratings$season)) s <- max(ratings$season)
  rnk <- ratings %>%
    filter(season == s & date <= dt) %>%
    group_by(gender,fisid,name) %>%
    mutate(season_races = n()) %>%
    filter(date == max(date) & race_count >= prov) %>%
    group_by(gender) %>%
    mutate(ranking = min_rank(-new_rating)) %>%
    arrange(gender,ranking) %>%
    select(fisid,name,nation,new_rating,ranking) %>%
    rename("Gender" = gender,"FIS ID" = fisid,"Name" = name,
           "Nation" = nation,"Rating" = new_rating,"Rank" = ranking) %>%
    as.data.frame
  setNames(split(rnk,rnk$Gender),c('Men','Women'))
}

date_to_season <- function(date){
  if (substr(date,6,7) %in% c('07','08','09','10','11','12')){
    yr <- as.integer(substr(date,1,4))
    out <- paste(yr,yr+1,sep = "-")
  }else{
    yr <- as.integer(substr(date,1,4))
    out <- paste(yr-1,yr,sep = "-")
  }
  out
}