# Load packages ----------------------------------------------------------------

library(shiny)
library(tidyverse)
library(gridExtra)

# Define UI --------------------------------------------------------------------

ui <- fluidPage(
    # Title ----
    titlePanel("Central Limit Theorem for Means", windowTitle = "CLT for means"),
    
    sidebarLayout(
        sidebarPanel(
            wellPanel(
                # Select distribution ----
                radioButtons("dist", "Parent distribution (population):",
                             c("Normal" = "rnorm",
                               "Uniform" = "runif",
                               "Right skewed" = "rlnorm",
                               "Left skewed" = "rbeta"),
                             selected = "rnorm"),
                # hr(),
                
                # Distribution parameters / features ----
                uiOutput("mu"),
                uiOutput("sd"),
                uiOutput("minmax"),
                uiOutput("skew"),
                
                # Select sample size ----
                sliderInput("n",
                            "Sample size:", 
                            value = 30,
                            min = 2,
                            max = 500),
                br(),
                
                # Number of samples ----
                sliderInput("k",
                            "Number of samples:",
                            value = 200,
                            min = 10,
                            max = 1000)
            ),
            
            # Informational text ---- 
            helpText(a(href="https://github.com/ShinyEd/ShinyEd/tree/master/CLT_mean", target="_blank", "View the code")),
            helpText(a(href="http://shinyed.github.io/intro-stats", target="_blank", "Check out other apps")),
            helpText(a(href="https://openintro.org", target="_blank", "Learn more for free!"))
            
        ),
        
        mainPanel(
            tabsetPanel(
                type = "tabs",
                # First tab ----
                tabPanel(
                    title = "Population Distribution",
                    # Population plot ----
                    plotOutput("pop.dist", height = "500px"),
                    br()
                ),
                # Second tab ----
                tabPanel(
                    title = "Samples",
                    # Sample plots ----
                    br(),
                    plotOutput("sample.dist", height = "600px"),
                    #  Number of samples text ----
                    div(h3(textOutput("num.samples")), align = "center"),
                    br()
                ),
                # Third tab ----
                tabPanel(
                    title = "Sampling Distribution",
                    
                    fluidRow(
                        column(width = 7,
                               br(), br(),
                               # CLT description ----
                               div(textOutput("CLT.descr"), align = "justify")),
                        column(width = 5,
                               br(),
                               # Population plot ----
                               plotOutput("pop.dist.two", width = "85%", height = "200px"))
                    ),
                    
                    fluidRow(
                        column(width = 12,
                               br(),
                               # Sampling plot ----
                               plotOutput("sampling.dist"),
                               # Sampling description ----
                               div(textOutput("sampling.descr", inline = TRUE), align = "center"))
                    )
                )
            )
        )
    )
)