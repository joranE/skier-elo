library(RSQLite)
library(dplyr)
#Distance
default_rating <- 1300
con <- statskier::db_xc()
dst <- statskier::query(con,
                        "select * 
                        from main 
                        where type = 'Distance' 
                        order by date,raceid,rank")
race_data_dst <- unique(dst[,c('raceid','length','tech','start','cat1','cat2')])
current_rating_dst <- unique(dst[,c('gender','fisid','name','nation','date')])
current_rating_dst <- current_rating_dst %>%
  group_by(gender,fisid,name) %>%
  summarise(nation = nation[date == max(date)][1])
current_rating_dst$race_count <- 0L
current_rating_dst$cur_rating <- default_rating

raceid_order <- unique(dst$raceid)
dst <- split(dst,dst$raceid)
dst <- dst[as.character(raceid_order)]

saveRDS(dst,"distance.rds")
saveRDS(current_rating_dst,"current_rating_dst.rds")

#Sprint
default_rating <- 1300
con <- statskier::db_xc()
spr <- statskier::query(con,
                        "select * 
              from main 
              where type = 'Sprint' and rank is not null 
              order by date,raceid,rank")
race_data_spr <- unique(spr[,c('raceid','length','tech','cat1','cat2')])
current_rating_spr <- unique(spr[,c('gender','fisid','name','nation','date')])
current_rating_spr <- current_rating_spr %>%
  group_by(gender,fisid,name) %>%
  summarise(nation = nation[date == max(date)][1])
current_rating_spr$race_count <- 0L
current_rating_spr$cur_rating <- default_rating

raceid_order <- unique(spr$raceid)

spr <- split(spr,spr$raceid)
spr <- spr[as.character(raceid_order)]

saveRDS(spr,"sprint.rds")
saveRDS(current_rating_spr,"current_rating_spr.rds")