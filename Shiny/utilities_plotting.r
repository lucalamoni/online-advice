### Plotting utilities

## Libraries
library(htmlwidgets)
library(dplyr)
library(ggplot2)
library(dygraphs)
library(htmltools)
library(widgetframe)
library(icesSAG)
library(plotly)




## Formatting axis title (titlefont)
titlefont_format <- function() {
    f1 <- list(
        family = "Calibri, sans-serif",
        size = 25,
        color = "darkgrey")
}
## Formatting tick axis font (tickfont)
tickfont_format <- function() {
    f2 <- list(
        family = "Calibri, serif",
        size = 20,
        color = "black")
}
## Formatting legend
legend_format <- function() {
    leg <- list(
        font = list(
        family = "sans-serif",
        size = 20,
        color = "#000"),
        bgcolor = "rgb(233,244,245)",
        bordercolor = "#FFFFFF",
        borderwidth = 2)
}

################## Plot 1 - Catches ################
figure_1_catches <- function(data, years, catches, landings, discards) {
    #Make sure that if the column landings is empy, the column catches is plotted
    if (all(is.na(data[, "landings"]))) {
        data$landings <- data$catches
    }
    # Start the plot
    fig1 <- plot_ly(
        data = data,
        x = ~years,
        y = ~landings,
        name = "Landings",
        type = "bar",
        hoverinfo = 'text',
        text = ~paste('Year:', Year, '<br>Landings:', landings),
        marker = list(color = '#66a4cd',
                      line = list(color = 'black',
                                  width = 0.5)),
        showlegend = TRUE)

    fig1 <- fig1 %>% add_trace(
        data = data,
        x = ~years,
        y = ~discards,
        name = "Discards",
        type = "bar",
        hoverinfo = 'text',
        text = ~paste('Year:', Year, '<br>Discards:', discards),
        marker = list(color = '#a00130',
                        line = list(color = 'black',
                                    width = 0.5)),
        showlegend = TRUE)

    fig1 <- fig1 %>% layout(title = "Catches",
            xaxis = list(title = "Years",
            titlefont = titlefont_format(),
            tickfont = tickfont_format(),
            showticklabels = TRUE),
            barmode = "stack",
            legend = legend_format(),
            yaxis = list(title = "Catches",
            titlefont = titlefont_format(),
            tickfont = tickfont_format(),
            showticklabels = TRUE))
    fig1

}

# figure_1_catches(catches, catches$Year, catches$landings, catches$discards)


################## Plot 2 - Recruitment ################
figure_2_recruitment <- function(data, years, recruitment, low_recruitment, high_recruitment){
    fig2 <- plot_ly(
            data = data,
            x = ~years,
            y = ~recruitment,
            name = "recruitment",
            type = "bar",
            hoverinfo = "text",
            text = ~ paste("Year:", years, "<br>recruitment:", recruitment),
            marker = list(
                color = "#cd6666",
                line = list(
                    color = "black",
                    width = 0.5
                )
            ),
            error_y = list(
                type = "data",
                symmetric = FALSE,
                arrayminus = ~low_recruitment,
                array = ~ high_recruitment,
                color = "#000000")
                #orientation = "v",
                #type = "bar"
            #)
            # error_y = list(
            #     array = ~err,
            #     type = "data",
            #     color = "#000000"
            # )
        )

        fig2 <- fig2 %>% layout(
            title = "Recruitment",
            xaxis = list(
                title = "Years",
                titlefont = titlefont_format(),
                tickfont = tickfont_format(),
                showticklabels = TRUE
            ),
            yaxis = list(
                title = "Recruitment",
                titlefont = titlefont_format(),
                tickfont = tickfont_format(),
                showticklabels = TRUE
            )
        )

    fig2

}
# figure_2_recruitment(R, R$Year, R$recruitment,R$low_recruitment,R$high_recruitment)


################## Plot 3 - Fish Mortality ################
figure_3_fish_mortality <- function(data, years, low_F, F, high_F, FLim, Fpa, FMSY){
    fig3 <- plot_ly(
        data = data, 
        x = ~years, 
        y = ~high_F, 
        type = "scatter", 
        mode = "lines",
        line = list(color = "transparent", shape = "linear"),#
        showlegend = FALSE, 
        name = "high_F"
    )
    fig3 <- fig3 %>% add_trace(
        data = data, 
        y = ~low_F, 
        type = "scatter", 
        mode = "lines",
        fill = "tonexty", 
        fillcolor = "rgba(255,71,26,0.2)", #"rgba(0,100,80,0.2)"
        line = list(color = "transparent", shape = "linear"),
        showlegend = FALSE, 
        name = "low_F"
    )
    fig3 <- fig3 %>% add_trace(
        data = data, 
        x = ~years, 
        y = ~F, 
        type = "scatter", 
        mode = "lines+markers",
        line = list(color = "rgb(255,71,26)", shape = "linear"), 
        name = "F",
        marker = list(size = 10, color = "rgb(255,71,26)"), 
        showlegend = TRUE
    )

    ## Add horizontal lines
    fig3 <- fig3 %>% add_trace(
        data = data, 
        x = ~years, 
        y = ~FLim, 
        name = "FLim", 
        type = "scatter", 
        mode = "lines",
        line = list(color = "black", shape = "linear", dash = "dash"), 
        showlegend = TRUE
    )
    fig3 <- fig3 %>% add_trace(
        data = data, 
        x = ~years, 
        y = ~Fpa, 
        name = "Fpa", 
        type = "scatter", 
        mode = "lines",
        line = list(color = "black", shape = "linear", dash = "dot"), 
        showlegend = TRUE
    )
    fig3 <- fig3 %>% add_trace(
        data = data, 
        x = ~years, 
        y = ~FMSY, 
        name = "FMSY", 
        type = "scatter", 
        mode = "lines",
        line = list(color = "orange", shape = "linear", dash = "dash"), 
        showlegend = TRUE
    )

    fig3 <- fig3 %>% layout(
        title = "F", 
        legend = legend_format(),
        paper_bgcolor = "rgb(255,255,255)", 
        plot_bgcolor = "rgb(229,229,229)",
        xaxis = list(
            title = "Years",
            gridcolor = "rgb(255,255,255)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        ),
        yaxis = list(
            title = "F",
            gridcolor = "rgb(255,255,255)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        )
    )

    fig3
    }

# figure_3_fish_mortality(f, f$Year, f$low_F, f$F, f$high_F, f$FLim, f$Fpa, f$FMSY)

################## Plot 4 - SBB ################
figure_4_SSB <- function(data, years, low_SSB, SSB, high_SSB, Blim, Bpa, MSYBtrigger){
    fig4 <- plot_ly(
        data = data, 
        x = ~years, 
        y = ~high_SSB, 
        type = "scatter", 
        mode = "lines",
        line = list(color = "transparent", shape = "linear"),
        showlegend = FALSE, 
        name = "high_SSB"
    )
    fig4 <- fig4 %>% add_trace(
        data = data, 
         x = ~years,
        y = ~low_SSB, 
        type = "scatter", 
        mode = "lines",
        fill = "tonexty", 
        fillcolor = "rgba(0,100,80,0.2)",
        line = list(color = "transparent", shape = "linear"),
        showlegend = FALSE, 
        name = "low_SSB"
    )
    fig4 <- fig4 %>% add_trace(
        data = data, 
        x = ~years, 
        y = ~SSB, 
        type = "scatter", 
        mode = "lines+markers",
        line = list(color = "rgb(0,100,80)", shape = "linear"), 
        name = "SSB",
        marker = list(size = 10), 
        showlegend = TRUE
    )

    ## Add horizontal lines
    fig4 <- fig4 %>% add_trace(
        data = data, 
        x = ~years, 
        y = ~Blim, 
        name = "Blim", 
        type = "scatter", 
        mode = "lines",
        line = list(color = "black", shape = "linear", dash = "dash"), 
        showlegend = TRUE
    )
    fig4 <- fig4 %>% add_trace(
        data = data, 
        x = ~years, 
        y = ~Bpa, 
        name = "Bpa", 
        type = "scatter", 
        mode = "lines",
        line = list(color = "black", shape = "linear", dash = "dot"), 
        showlegend = TRUE
    )
    fig4 <- fig4 %>% add_trace(
        data = data, 
        x = ~years, 
        y = ~MSYBtrigger, 
        name = "MSYBtrigger", 
        type = "scatter", 
        mode = "lines",
        line = list(color = "orange", shape = "linear", dash = "dash"), 
        showlegend = TRUE
    )

    fig4 <- fig4 %>% layout(
        title = "SSB", 
        legend = legend_format(),
        paper_bgcolor = "rgb(255,255,255)", 
        plot_bgcolor = "rgb(229,229,229)",
        xaxis = list(
            title = "Years",
            gridcolor = "rgb(255,255,255)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        ),
        yaxis = list(
            title = "SSB",
            gridcolor = "rgb(255,255,255)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        )
    )


    fig4
}

#figure_4_SSB(SSB, SSB$Year, SSB$low_SSB, SSB$SSB, SSB$high_SSB, SSB$Blim, SSB$Bpa, SSB$MSYBtrigger)



#####################Subplots quality of assessment
quality_assessment_plots <- function(big_data, big_data_last_year,
                                        stockSizeDescription,stockSizeUnits,
                                        Fage, fishingPressureDescription,
                                        RecruitmentAge) {

## Labels for axes and annotation for the plots, taken from SAG
SSB_yaxis_label <- sprintf("%s (%s)", dplyr::last(stockSizeDescription), dplyr::last(stockSizeUnits))
F_yaxis_label <- sprintf("%s <sub>(ages %s)</sub>",dplyr::last(fishingPressureDescription), dplyr::last(Fage))
R_yaxis_label <- sprintf("Recruitment <sub>(age %s)</sub>", dplyr::last(RecruitmentAge))


 fig1 <- plot_ly(
     data = big_data,
     x = ~Year,
     y = ~SSB,
     split = ~AssessmentYear,
     type = "scatter",
     mode = "lines+markers",
    #  line = list(shape = "spline"),
     connectgaps = FALSE,
     color = ~AssessmentYear
 )
 fig1 <- fig1 %>% add_trace(
        data = big_data_last_year, ###select for last reference points last year
        x = ~Year, 
        y = ~Blim, 
        name = "Blim", 
        type = "scatter", 
        mode = "lines",
        line = list(color = "black", shape = "linear", dash = "dash", width = 2), 
        showlegend = TRUE
    )
    fig1 <- fig1 %>% add_trace(
        data = big_data_last_year, 
        x = ~Year, 
        y = ~Bpa, 
        name = "Bpa", 
        type = "scatter", 
        mode = "lines",
        line = list(color = "black", shape = "linear", dash = "dot", width = 2), 
        showlegend = TRUE
    )

    fig1 <- fig1 %>% add_trace(
        data = big_data_last_year, 
        x = ~Year, 
        y = ~MSYBtrigger, 
        name = "MSYBtrigger", 
        type = "scatter", 
        mode = "lines",
        line = list(color = "#679dfe", shape = "linear", width = 1), 
        showlegend = TRUE
    )
 fig1 <- fig1 %>% layout(
        # title = "SSB", 
        legend = legend_format(),
        paper_bgcolor = "rgb(246,250,251)", 
        plot_bgcolor = "rgb(255,255,255)",
        xaxis = list(
            title = "Years",
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        ),
        yaxis = list(
            title = SSB_yaxis_label,
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        )
    )

 fig2 <- plot_ly(
     data = big_data,
     x = ~Year,
     y = ~F,
     split = ~AssessmentYear,
     type = "scatter",
     mode = "lines+markers",
    #  line = list(shape = "spline"),
     connectgaps = FALSE,
     color = ~AssessmentYear,
     showlegend = FALSE
 )
 ## Add horizontal lines
    fig2 <- fig2 %>% add_trace(
        data = big_data_last_year, 
        x = ~Year, 
        y = ~FLim, 
        name = "FLim", 
        type = "scatter", 
        mode = "lines",
        line = list(color = "black", shape = "linear", dash = "dash", width = 2), 
        showlegend = TRUE
    )
    fig2 <- fig2 %>% add_trace(
        data = big_data_last_year, 
        x = ~Year, 
        y = ~Fpa, 
        name = "Fpa", 
        type = "scatter", 
        mode = "lines",
        line = list(color = "black", shape = "linear", dash = "dot", width = 2), 
        showlegend = TRUE
    )

    fig2 <- fig2 %>% add_trace(
        data = big_data_last_year, 
        x = ~Year, 
        y = ~FMSY, 
        name = "FMSY", 
        type = "scatter", 
        mode = "lines",
        line = list(color = "#679dfe", shape = "linear", width = 1), 
        showlegend = TRUE
    )
fig2 <- fig2 %>% layout(
        # title = "F", 
        legend = legend_format(),
        paper_bgcolor = "rgb(246,250,251)", 
        plot_bgcolor = "rgb(255,255,255)",
        xaxis = list(
            title = "Years",
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        ),
        yaxis = list(
            title = F_yaxis_label,
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        )
    )

 fig3 <- plot_ly(
     data = big_data,
     x = ~Year,
     y = ~recruitment,
     split = ~AssessmentYear,
     type = "scatter",
     mode = "lines+markers",
    #  line = list(shape = "spline"),
     connectgaps = FALSE,
     color = ~AssessmentYear,
     showlegend = FALSE
 )
fig3 <- fig3 %>% layout(
        # title = "R", 
        legend = legend_format(),
        paper_bgcolor = "rgb(246,250,251)", 
        plot_bgcolor = "rgb(255,255,255)",
        xaxis = list(
            title = "Years",
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        ),
        yaxis = list(
            title = R_yaxis_label,
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        )
    )

 fig_qass <- subplot(fig1, fig2, fig3, 
 nrows = 3, shareX = TRUE, titleX = TRUE, titleY = TRUE,  heights = c(0.33, 0.33, 0.33), margin = c(0.05,0.05,0.01,0.01))#, ,
#  nrows = 1,
#    widths = NULL,
#    heights = NULL,
#    margin = 0.02,
#    shareX = TRUE,
#    shareY = FALSE,
#    titleX = shareX)
#    titleY = shareY,
#    which_layout = "merge")
 fig_qass
}

# quality_assessment_plots(big_data, big_data_last_year)

figure_1_plots <- function(data1, data2, data3, data4, 
                            years, 
                            catches, landings, discards, units, stock_name, AssessmentYear,
                            recruitment, low_recruitment, high_recruitment, recruitment_age, 
                            low_F, F, high_F, FLim, Fpa, FMSY,Fage, fishingPressureDescription,
                            low_SSB, SSB, high_SSB, Blim, Bpa, MSYBtrigger, stockSizeDescription, stockSizeUnits) {
    if (all(is.na(data1[, "landings"]))) {
        data1$landings <- data1$catches
    }

    ## Labels for axes and annotation for the plots, taken from SAG
    catches_yaxis_label <- sprintf("Catches (%s)", dplyr::last(units))
    R_yaxis_label <- sprintf("Recruitment <sub>(age %s)</sub>", dplyr::last(recruitment_age))
    F_yaxis_label <- sprintf("%s <sub>(ages %s)</sub>",dplyr::last(fishingPressureDescription), dplyr::last(Fage))
    SSB_yaxis_label<- sprintf("%s (%s)", dplyr::last(stockSizeDescription), dplyr::last(stockSizeUnits))
    
    Stockcode_year_annotation_1 <- list( showarrow = FALSE,
                                        text = sprintf("%s, %s", dplyr::last(stock_name), dplyr::last(AssessmentYear)),
                                        font = list(family = "Calibri, serif",size = 10, color = "black"),
                                        yref = 'paper', y = 1, xref = "paper", x = 0.8
                                        )
    Stockcode_year_annotation_2 <- list( showarrow = FALSE,
                                        text = sprintf("%s, %s", dplyr::last(stock_name), dplyr::last(AssessmentYear)),
                                        font = list(family = "Calibri, serif",size = 10, color = "black"),
                                        yref = 'paper', y = 1, xref = "paper", x = 0.95
                                        )
    Stockcode_year_annotation_3 <- list( showarrow = FALSE,
                                            text = sprintf("%s, %s", dplyr::last(stock_name), dplyr::last(AssessmentYear)),
                                            font = list(family = "Calibri, serif",size = 10, color = "black"),
                                            yref = 'paper', y = 0.97, xref = "paper", x = 0.8
                                            )
    Stockcode_year_annotation_4 <- list( showarrow = FALSE,
                                        text = sprintf("%s, %s", dplyr::last(stock_name), dplyr::last(AssessmentYear)),
                                        font = list(family = "Calibri, serif",size = 10, color = "black"),
                                        yref = 'paper', y = 0.97, xref = "paper", x = 0.95
                                        )
    
    # Start the plot
    fig1 <- plot_ly(
        data = data1,
        x = ~years,
        y = ~landings,
        name = "Landings",
        type = "bar",
        hoverinfo = "text",
        text = ~ paste("Year:", Year, "<br>Landings:", landings),
        marker = list(
            color = "#002b5f", # BMSlandings #047c6c
            line = list(
                color = "#d0d1d6",
                width = 0.5
            )
        ),
        showlegend = TRUE
    )

    fig1 <- fig1 %>% add_trace(
        data = data1,
        x = ~years,
        y = ~discards,
        name = "Discards",
        type = "bar",
        hoverinfo = "text",
        text = ~ paste("Year:", Year, "<br>Discards:", discards),
        marker = list(
            color = "#fda500",
            line = list(
                color = "#d0d1d6",
                width = 0.5
            )
        ),
        showlegend = TRUE
    )

    fig1 <- fig1 %>% layout(
        # title = "Catches",
        paper_bgcolor = "rgb(246,250,251)",
        plot_bgcolor = "rgb(255,255,255)",

        xaxis = list(
            title = "Years",
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            tickcolor = "rgb(127,127,127)",
            titlefont = titlefont_format(),
            tickfont = tickfont_format(),
            showticklabels = TRUE
        ),
        barmode = "stack",
        legend = legend_format(),
        yaxis = list(
            title = catches_yaxis_label,#"Catches",
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            tickcolor = "rgb(127,127,127)",
            titlefont = titlefont_format(),
            tickfont = tickfont_format(),
            showticklabels = TRUE
        ),
        annotations = list(Stockcode_year_annotation_1)
    )

    fig2 <- plot_ly(
        data = data2,
        x = ~years,
        y = ~recruitment,
        name = "Recruitment",
        type = "bar",
        hoverinfo = "text",
        text = ~ paste("Year:", years, "<br>Recruitment:", recruitment),
        marker = list(
            color = "#28b3e8", #last yesr #92defb
            line = list(
                color = "#d0d1d6",
                width = 0.5
            )
        ),
        error_y = list(
            type = "data",
            symmetric = FALSE,
            arrayminus = ~low_recruitment,
            array = ~high_recruitment,
            color = "rgba(169,169,169,0.5)"
        )
    )

    fig2 <- fig2 %>% layout(
        # title = "Recruitment",
        paper_bgcolor = "rgb(246,250,251)",
        plot_bgcolor = "rgb(255,255,255)",

        xaxis = list(
            title = "Years",
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            tickcolor = "rgb(127,127,127)",
            titlefont = titlefont_format(),
            tickfont = tickfont_format(),
            showticklabels = TRUE
        ),
        yaxis = list(
            title = R_yaxis_label,#"Recruitment",
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            tickcolor = "rgb(127,127,127)",
            titlefont = titlefont_format(),
            tickfont = tickfont_format(),
            showticklabels = TRUE
        ),
        annotations = list(Stockcode_year_annotation_2)
    )

    fig3 <- plot_ly(
        data = data3,
        x = ~years,
        y = ~high_F,
        type = "scatter",
        mode = "lines",
        line = list(color = "transparent", shape = "linear"), #
        showlegend = FALSE,
        name = "high_F"
    )
    fig3 <- fig3 %>% add_trace(
        data = data3,
        y = ~low_F,
        type = "scatter",
        mode = "lines",
        fill = "tonexty",
        fillcolor = "#f2a497", # "rgba(0,100,80,0.2)"rgba(255,71,26,0.2)
        line = list(color = "transparent", shape = "linear"),
        showlegend = FALSE,
        name = "low_F"
    )
    fig3 <- fig3 %>% add_trace(
        data = data3,
        x = ~years,
        y = ~F,
        type = "scatter",
        mode = "lines+markers",
        line = list(color = "#ed5f26", shape = "linear"), #"rgb(255,71,26)"
        name = "F",
        marker = list(size = 1, color = "#ed5f26"),
        showlegend = TRUE
    )

    ## Add horizontal lines
    fig3 <- fig3 %>% add_trace(
        data = data3,
        x = ~years,
        y = ~FLim,
        name = "FLim",
        type = "scatter",
        mode = "lines",
        line = list(color = "black", shape = "linear", dash = "dash", width = 2),
        showlegend = TRUE
    )
    fig3 <- fig3 %>% add_trace(
        data = data3,
        x = ~years,
        y = ~Fpa,
        name = "Fpa",
        type = "scatter",
        mode = "lines",
        line = list(color = "black", shape = "linear", dash = "dot", width = 2),
        showlegend = TRUE
    )
    fig3 <- fig3 %>% add_trace(
        data = data3,
        x = ~years,
        y = ~FMSY,
        name = "FMSY",
        type = "scatter",
        mode = "lines",
        line = list(color = "#679dfe", shape = "linear", width = 1),#, dash = "dash"),
        showlegend = TRUE
    )

    fig3 <- fig3 %>% layout(
        # title = "F",
        legend = legend_format(),
        paper_bgcolor = "rgb(246,250,251)",
        plot_bgcolor = "rgb(255,255,255)",
        xaxis = list(
            title = "Years",
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        ),
        yaxis = list(
            title = F_yaxis_label, #"F",
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        ),
        annotations = list(Stockcode_year_annotation_3)
    )
    fig4 <- plot_ly(
        data = data4,
        x = ~years,
        y = ~high_SSB,
        type = "scatter",
        mode = "lines",
        line = list(color = "transparent", shape = "linear"),
        showlegend = FALSE,
        name = "high_SSB"
    )
    fig4 <- fig4 %>% add_trace(
        data = data4,
        x = ~years,
        y = ~low_SSB,
        type = "scatter",
        mode = "lines",
        fill = "tonexty",
        fillcolor = "#94b0a9", #rgba(0,100,80,0.2)
        line = list(color = "transparent", shape = "linear"),
        showlegend = FALSE,
        name = "low_SSB"
    )
    fig4 <- fig4 %>% add_trace(
        data = data4,
        x = ~years,
        y = ~SSB,
        type = "scatter",
        mode = "lines+markers",
        line = list(color = "#047c6c", shape = "linear"), #rgb(0,100,80)
        name = "SSB",
        marker = list(size = 1, color = "#047c6c"),
        showlegend = TRUE
    )

    ## Add horizontal lines
    fig4 <- fig4 %>% add_trace(
        data = data4,
        x = ~years,
        y = ~Blim,
        name = "Blim",
        type = "scatter",
        mode = "lines",
        line = list(color = "black", shape = "linear", dash = "dash", width = 2),
        showlegend = TRUE
    )
    fig4 <- fig4 %>% add_trace(
        data = data4,
        x = ~years,
        y = ~Bpa,
        name = "Bpa",
        type = "scatter",
        mode = "lines",
        line = list(color = "black", shape = "linear", dash = "dot", width = 2),
        showlegend = TRUE
    )
    fig4 <- fig4 %>% add_trace(
        data = data4,
        x = ~years,
        y = ~MSYBtrigger,
        name = "MSYBtrigger",
        type = "scatter",
        mode = "lines",
        line = list(color = "#679dfe", shape = "linear", width = 1),#, dash = "dash"),
        showlegend = TRUE
    )

    fig4 <- fig4 %>% layout(
        # title = "SSB",
        legend = legend_format(),
        paper_bgcolor = "rgb(246,250,251)",
        plot_bgcolor = "rgb(255,255,255)",
        xaxis = list(
            title = "Years",
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        ),
        yaxis = list(
            title = SSB_yaxis_label,#"SSB",
            gridcolor = "rgb(235,235,235)",
            showgrid = TRUE,
            showline = TRUE,
            showticklabels = TRUE,
            tickcolor = "rgb(127,127,127)",
            ticks = "outside",
            zeroline = TRUE,
            titlefont = titlefont_format(),
            tickfont = tickfont_format()
        ),
        annotations = list(Stockcode_year_annotation_4)
    )

    fig <- subplot(fig1, fig2, fig3, fig4,
        nrows = 2, shareX = TRUE, titleX = TRUE, titleY = TRUE, widths = c(0.5, 0.5), heights = c(0.5, 0.5), margin = c(0.06,0.06,0.02,0.02)
    ) #
    fig
}


####### plots 1 catch scenarios
catch_scenarios_plot1 <- function(tmp) {
    # tmp <- get_catch_scenario_table(stock_name = "cod.27.47d20") #ple.27.7d
    tmp$Year <- 2022

    tmp2 <- tmp %>% select(Year, cS_Label, `Ftotal (2020)`, `SSB (2021)`, `Total catch (2020)`, `% TAC change (2020)`, `% Advice change (2020)`, `% SSB change (2021)`)

    colnames(tmp2) <- c("Year", "cat", "F", "SSB", "TotCatch", "TACchange", "ADVICEchange", "SSBchange")
    tmp2 <- tmp2 %>% do(bind_rows(., data.frame(Year = 2022, cat = "ref", F = 0, SSB = 0, TotCatch = 0, TACchange = 0, ADVICEchange = 0, SSBchange = 0)))

    sc <- head(tmp2$cat)

    tmp3 <- tmp2 %>% mutate(
        F = rescale(F, to = c(0, 1), from = range(c(min(F), max(F)))),
        SSB = rescale(SSB, to = c(0, 1), from = range(c(min(SSB), max(SSB)))),
        TotCatch = rescale(TotCatch, to = c(0, 1), from = range(c(min(TotCatch), max(TotCatch)))),
        TACchange = rescale(TACchange, to = c(0, 1), from = range(c(-100, 100))),
        ADVICEchange = rescale(ADVICEchange, to = c(0, 1), from = range(c(-100, 100))),
        SSBchange = rescale(SSBchange, to = c(0, 1), from = range(c(-100, 100))),
    )

    zz <- ggplotly(
        ggradar(tmp3 %>% select(-Year), values.radar = c("0", "0.5", "1"))
    )
    zz
}

catch_scenarios_plot2 <- function(tmp) {
    tmp$Year <- 2022

    tmp2 <- tmp %>% select(Year, cS_Label, `Ftotal (2020)`, `SSB (2021)`, `Total catch (2020)`, `% TAC change (2020)`, `% Advice change (2020)`, `% SSB change (2021)`)

    colnames(tmp2) <- c("Year", "cat", "F", "SSB", "TotCatch", "TACchange", "ADVICEchange", "SSBchange")
    tmp2 <- tmp2 %>% do(bind_rows(., data.frame(Year = 2022, cat = "ref", F = 0, SSB = 0, TotCatch = 0, TACchange = 0, ADVICEchange = 0, SSBchange = 0)))

    sc <- head(tmp2$cat)


    fig_F <- plot_ly(arrange(tmp2, F),
        x = ~TotCatch, y = ~F, mode = "lines+markers", text = ~cat,
        marker = list(size = 20)
    )
    fig_F <- fig_F %>% add_annotations(
        x = ~TotCatch, y = ~F,
        text = ~cat,
        textfont = list(color = "#000000", size = 30),
        xref = "x",
        yref = "y",
        showarrow = TRUE,
        arrowhead = 4,
        arrowsize = .5,
        ax = c(20, -20),
        ay = c(-80, 40, 80)
    )
     fig_F <- fig_F %>% layout(
        xaxis = list(
             title = "Total Catch"),
        yaxis= list(
             title = "F")
     )



    fig_SSB <- plot_ly(arrange(tmp2, F),
        x = ~TotCatch, y = ~SSB, mode = "lines+markers", text = ~cat,
        marker = list(size = 20)
    )
    fig_SSB <- fig_SSB %>% add_annotations(
        x = ~TotCatch, y = ~SSB,
        text = ~cat,
        textfont = list(color = "#000000", size = 30),
        xref = "x",
        yref = "y",
        showarrow = TRUE,
        arrowhead = 4,
        arrowsize = .5,
        ax = c(20, -20),
        ay = c(-80, 40, 80)
    )
    fig_SSB <- fig_SSB %>% layout(
        xaxis = list(
             title = "Total Catch"),
        yaxis= list(
             title = "SSB")
     )

    fig <- subplot(fig_F, fig_SSB,
        nrows = 1, shareX = TRUE, titleX = TRUE, titleY = TRUE#, heights = c(1, 1)
    ) # widths = c(0.5, 0.5), heights = c(0.5, 0.5), margin = c(0.06,0.06,0.02,0.02)
    # ))

    fig
}