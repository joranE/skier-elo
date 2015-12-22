library(RSQLite)
library(dplyr)
#Distance
default_rating <- 1300
conl <- statskier2::db_xc_local()
dst <- statskier2::ss_query(conl,
                        "select * 
                        from main 
                        where type = 'Distance' 
                        order by date,raceid,rank")
race_data_dst <- unique(dst[,c('raceid','length','tech','start','cat1','cat2')])
raceid_date_dst <- unique(dst[,c('raceid','date')])
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
saveRDS(raceid_date_dst,"raceid_date_dst.rds")

#Sprint
default_rating <- 1300
conl <- statskier2::db_xc_local()
spr <- statskier2::ss_query(conl,
                        "select * 
              from main 
              where type = 'Sprint' and rank is not null 
              order by date,raceid,rank")
race_data_spr <- unique(spr[,c('raceid','length','tech','cat1','cat2')])
raceid_date_spr <- unique(spr[,c('raceid','date')])
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
saveRDS(raceid_date_spr,"raceid_date_spr.rds")