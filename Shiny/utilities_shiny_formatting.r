side_width <- 4

# allocations advice information panel
allocations_infopanel <-
  sidebarPanel(
    width = 8,
    panel(
      title = "plots",
      fillPage(
        tags$style(type = "text/css", "#all_plots {height: calc(100vh - 200px) !important;}"),
        plotlyOutput("all_plots", height = "100%", width = "100%")
      ),
      h5(helpText("Stock Development over time"))
    )
  )

# advice plot side panel
allocations_plotspanel <-
  sidebarPanel(
    width = 4,
    # tabsetPanel(
    #     tabPanel(
    #         title = "Catches",
    #         plotlyOutput("catches"),
    #         h5(helpText("Figure 1: Catches"))
    #         # actionButton("r_catches", "Get Stock Data")
    #     ),
    #     tabPanel(
    #         title = "Recruitment",
    #         plotlyOutput("R"),
    #         h5(helpText("Figure 2: Stock recruitment"))
    #         # actionButton("r_recr", "Get Stock Data")
    #     ),
    #     tabPanel(
    #         title = "Fishing Pressure",
    #         plotlyOutput("f"),
    #         h5(helpText("Figure 3: Fish mortality"))
    #         # actionButton("r_f", "Get Stock Data")
    #     ),
    #     tabPanel(
    #         title = "SSB",
    #         plotlyOutput("SSB"),
    #         h5(helpText("Figure 4: SSB"))
    #         # actionButton("r_SSB", "Get Stock Data")
    #     ),
    #     tabPanel(
      panel(
        title = "Quality of Assessment",
        fillPage(
          tags$style(type = "text/css", "#Q_Ass {height: calc(100vh - 200px) !important;}"),
          plotlyOutput("Q_Ass", height = "100%", width = "100%")
        ),
        h5(helpText("Quality of Assessment"))
        # actionButton("r_SSB", "Get Stock Data")
      )
        # )
    # ),
    # DTOutput("tbl_summary")
    )


# maps_panels <-
  # sidebarPanel(
  #   width = 8,
  #   tabsetPanel(
  #     tabPanel("ICES Ecoregions", leafletOutput("map1", height = 800)),
  #     tabPanel("ICES Areas", leafletOutput("map2", height = 800))
  #   )
  # )
maps_panels <-
  sidebarPanel(
    width = 8,
    tabsetPanel(
      tabPanel(
        "ICES Ecoregions",
        fillPage(
          tags$style(type = "text/css", "#map1 {height: calc(100vh - 200px) !important;}"),
          leafletOutput("map1", height = "100%", width = "100%")
        )
      ),
      tabPanel(
        "ICES Areas",
        fillPage(
          tags$style(type = "text/css", "#map2 {height: calc(100vh - 200px) !important;}"),
          leafletOutput("map2", height = "100%", width = "100%")
        )
      )
    )
  )

selectize_panel <-
  mainPanel(
    width = 4, style = "max-height: 90vh; overflow-y: auto;",
    panel(
      selectizeInput(
        inputId = "selected_locations",
        label = "ICES Ecoregions",
        choices = shape_eco$Ecoregion,
        selected = NULL,
        multiple = TRUE,
        options = list(
          placeholder = "Select Ecoregion(s)"
        )
      ),
      selectizeInput(
        inputId = "selected_areas",
        label = "ICES Areas",
        choices = ices_areas$Area_Full,
        selected = NULL,
        multiple = TRUE,
        options = list(
          placeholder = "Select ICES Area(s)"
        )
      ),
      #######
      selectizeInput(
        inputId = "selected_years",
        label = "Year SID/SAG",
        choices = Years$Year,
        selected = 2021,
        multiple = FALSE,
        options = list(
          placeholder = "Select ICES Area(s)"
        )
      ),
      #######

      selectizeGroupUI(
        id = "my-filters",
        params = list(
          # EcoRegion = list(inputId = "EcoRegion", title = "EcoRegion:"),
          # StockDatabaseID = list(inputId = "StockDatabaseID", title = "StockDatabaseID:"),
          # StockKey = list(inputId = "StockKey", title = "StockKey:"),
          StockKeyLabel = list(inputId = "StockKeyLabel", title = "StockKeyLabel:"),
          # SpeciesScientificName = list(inputId = "SpeciesScientificName", title = "SpeciesScientificName:"),
          SpeciesCommonName = list(inputId = "SpeciesCommonName", title = "SpeciesCommonName:"),
          ExpertGroup = list(inputId = "ExpertGroup", title = "ExpertGroup:"),
          # AdviceDraftingGroup = list(inputId = "AdviceDraftingGroup", title = "AdviceDraftingGroup:"),
          DataCategory = list(inputId = "DataCategory", title = "DataCategory:"),
          YearOfLastAssessment = list(inputId = "YearOfLastAssessment", title = "YearOfLastAssessment:"),
          # AssessmentFrequency = list(inputId = "AssessmentFrequency", title = "AssessmentFrequency:"),
          # YearOfNextAssessment = list(inputId = "YearOfNextAssessment", title = "YearOfNextAssessment:"),
          # AdviceReleaseDate = list(inputId = "AdviceReleaseDate", title = "AdviceReleaseDate:"),
          AdviceCategory = list(inputId = "AdviceCategory", title = "AdviceCategory:"),
          # AdviceType = list(inputId = "AdviceType", title = "AdviceType:"),
          # TrophicGuild = list(inputId = "TrophicGuild", title = "TrophicGuild:"),
          # FisheriesGuild = list(inputId = "FisheriesGuild", title = "FisheriesGuild:"),
          # SizeGuild = list(inputId = "SizeGuild", title = "SizeGuild:"),
          Published = list(inputId = "Published", title = "Published:")
          # ICES_area = list(inputId = "ICES_area", title = "ICES_area")
        ),
        inline = FALSE
      ),
      heading = "Data filtering",
      status = "primary"
    )
  )


# catch_scenarios_left_panel <- sidebarPanel(
#   width = 6,
#   panel(
#     title = "Headline advice",
#     fillPage(
#       tags$style(type = "text/css", "#Advice_Sentence2 {height: 20%; width: 50%}"),
#       htmlOutput("Advice_Sentence2")
#     )
#   ),
#   panel(
#     title = "Catch_scenario_F_SSB",
#     fillPage(
#       tags$style(type = "text/css", "#catch_scenario_plot_3 {height: 50%; width: 50%}"),
#       plotlyOutput("catch_scenario_plot_3")
#     )
#   ),
#   panel(
#     title = "TAC_timeline",
#     fillPage(
#       tags$style(type = "text/css", "#TAC_timeline {height: 40%; width: 50%}"),
#       plotlyOutput("TAC_timeline")
#     )
#   )
# )


# catch_scenarios_right_panel <- mainPanel(
#   width = 6,
#   panel(
#     title = "Advice timeline",
#     fillPage(
#       tags$style(type = "text/css", "#advice_timeline {height: 20%; width: 50%}"),
#       timevisOutput("advice_timeline")
#     )
#   ),
#   panel(
#     title = "Catch scenario table",
#     fillPage(
#       tags$style(type = "text/css", "#table {height: 80%; width: 50%}"),
#       DTOutput("table")
#     )
#   )
# )

catch_scenarios_left_panel <- sidebarPanel(
  width = 6,
  fillPage(
    # tags$style("max-height: 50vh; overflow-y: auto; {height: calc(100vh - 200px) !important;}"),
    htmlOutput("Advice_Sentence2", height = "20%", width = "100%"),
    plotlyOutput("catch_scenario_plot_3", height = "20%", width = "100%"),
    plotlyOutput("TAC_timeline", height = "40%", width = "100%")
  )
)
catch_scenarios_right_panel <- mainPanel(
  width = 6,
  fillPage(
    # tags$style("max-height: 50vh; overflow-y: auto;"),
    timevisOutput("advice_timeline", height = "20%", width = "100%"),
    DTOutput("table", height = "80%", width = "100%")
  )
)