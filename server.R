library(shiny)
library(shinydashboard)
library(skierELO)
library(dplyr)
source("load_data.R")
source("helpers.R")

function(input, output, session) {
  
  out <- reactive({
    progress <- shiny::Progress$new(session,min = 1,max = 15)
    on.exit(progress$close())
    progress$set(message = "Calculating:",
                 detail = "this may take a few moments...")
    
    if (input$type == 'Distance'){
      Date <- as.character(input$date)
      Season <- date_to_season(Date)
      K <- K_DST_MIN + ((K_DST_MAX - K_DST_MIN) * input$Kfactor)
      raceid <- RACEID_DATE_DST$raceid[RACEID_DATE_DST$date <= Date]
      dst <- DST[as.character(raceid)]
      
      elo <- calc_elo_dst(races = dst,
                   current_rating = CURRENT_RATING_DST,
                   K = K,
                   P = P, 
                   provisional_n = PROVISIONAL_N,
                   season_shrink = SEASON_SHRINK)
      
      rnk <- ath_ranking(s = Season,
                  dt = Date,
                  ratings = elo)
    }
    if (input$type == 'Sprint'){
      Date <- as.character(input$date)
      Season <- date_to_season(Date)
      K <- K_SPR_MIN + ((K_SPR_MAX - K_SPR_MIN) * input$Kfactor)
      raceid <- RACEID_DATE_SPR$raceid[RACEID_DATE_SPR$date <= Date]
      spr <- SPR[as.character(raceid)]
      
      elo <- calc_elo_spr(races = spr,
                   current_rating = CURRENT_RATING_SPR,
                   K = K,
                   P = P, 
                   provisional_n = PROVISIONAL_N,
                   season_shrink = SEASON_SHRINK)
      
      
      rnk <- ath_ranking(s = Season,
                  dt = Date,
                  ratings = elo)
    }
    rnk
  })
 
   output$men <- renderDataTable(out()$Men,
                                 options = list(pageLength = 15,
                                                autoWidth = FALSE,
                                                ordering = FALSE,
                                                columnDefs = list(list(targets = c(0,4),searchable = FALSE),
                                                                  list(targets = 0,width = "10px"),
                                                                  list(targets = 1,width = "30px"),
                                                                  list(targets = 2,width = "150px"),
                                                                  list(targets = 3,width = "10px"),
                                                                  list(targets = 4,width = "30px"),
                                                                  list(targets = 5,width = "10px"))))
   output$wom <- renderDataTable(out()$Women,
                                 options = list(pageLength = 15,
                                                autoWidth = FALSE,
                                                ordering = FALSE,
                                                columnDefs = list(list(targets = c(0,4),searchable = FALSE),
                                                                  list(targets = 0,width = "10px"),
                                                                  list(targets = 1,width = "30px"),
                                                                  list(targets = 2,width = "150px"),
                                                                  list(targets = 3,width = "10px"),
                                                                  list(targets = 4,width = "30px"),
                                                                  list(targets = 5,width = "10px"))))
 
}
