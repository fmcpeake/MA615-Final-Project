library(officer)
library(magrittr)
library(tidyverse)
library(readxl)
#Reading in companies in the DJI and formatting 
my_pres<-read_pptx("blank1.pptx") 

knitr::kable(layout_summary(my_pres))

#Strings to be included in ppt
first = "Decide if this is a market correction or the start of something more"
second = "Review the stocks you own"
third = "Review stocks you wanted to own but were too expensive at time of 
research"
fourth = "Check your portfolio for balance or the type of stocks you own"
two.one = "CDC surveyed 500 largest cities in America"
two.two = "Measured chronic diseases, risky behaviors, and preventative behaviors"
two.two.one = "Measured down to Census Tract"
two.two.two = "Meant to help implement change by targeting specific areas"
two.three = "First study of its kind"
two.four = "Benford Analysis"
two.five = "Used to analyze fraud in large lists of numbers by looking at the first digits"
two.five.one = "Typically used for financial purposes, but should work on any long list of numbers"
two.five.one.one = "No variable followed Benford's Law"
two.five.one.two = "All variables followed one of the distributions below"
two.five.two = "No!"
two.five.two.one = "There isn't a lot of variance in responses, so the digits are in a small range"
two.five.two.two = "So the leading digits are all clustered together"

title.text <- fp_text(font.size = 14)
#Slides
my_pres<-
  read_pptx("blank1.pptx") %>%
  add_slide(layout = "Title Slide", master = "Badge") %>% #Slide 1
  ph_with_text(type = "ctrTitle", str = "500 Cities Project") %>%
  ph_with_text(type = "subTitle", str = "Fraud in Health Surveys") %>%
  add_slide(layout = "Two Content", master = "Badge") %>% #Slide 2
  ph_with_text(type = "title", str = "What is 500 Cities?") %>%
  ph_with_ul(type = "body", index = 1, str_list = c(two.one, two.two, two.two.one), 
             level_list = c(1, 1, 1))%>%
  ph_with_ul(type = "body", index = 2, str_list = c(two.two.two, two.three), level_list = c(1,1)) %>%
  
   add_slide(layout = "Title and Content", master = "Badge") %>% #Slide 3
   ph_with_text(type = "title", str = "Method Used") %>%
   ph_with_ul(type = "body", index = 1, str_list = c(two.four, two.five, two.five.one), 
                level_list = c(1,1,1)) %>%
  
   add_slide(layout = "Title and Content", master = "Badge") %>% #Slide 4
   ph_with_text(type = "title", str = "Results") %>%
   ph_with_ul(type = "body", index = 1, str_list = c(two.five.one.one, two.five.one.two), 
              level_list = c(1,1)) %>%
   ph_with_img_at(src = "clustered.PNG", height = 3, width = 3, left = 4, top = 4) %>%
   ph_with_img_at(src = "Spread.PNG", height = 3, width = 3, left = 1, top = 4) %>%
  
   add_slide(layout = "Title and Content", master = "Badge") %>% #Slide 5
   ph_with_text(type = "title", str = "Is there fraud?") %>%
   ph_with_ul(type = "body", index = 1, str_list = c(two.five.two, two.five.two.one, two.five.two.two), 
              level_list = c(1,1,1)) %>%
  

print(my_pres, target = "blank1.pptx") 
