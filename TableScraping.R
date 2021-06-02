library(rvest)
library(dplyr)
library(xml2)
  
  # Tables
  
  col_link = "https://www.numbeo.com/cost-of-living/compare_countries_result.jsp?country1=Morocco&country2=Germany"
  col_page = read_html(col_link)
  
  col_table = col_page %>% html_nodes("table.data_wide_table.new_bar_table.cost_comparison_table") %>% html_table() %>% .[[1]]
  
  
  wiki_link = "https://en.wikipedia.org/wiki/Star"
  wiki_page = read_html(wiki_link)
  
  # Lifetimes of stages of stellar evolution in billions of years
  stellar_table = wiki_page %>% html_nodes("table.wikitable") %>% .[1] %>%  
    html_table(fill = TRUE) %>% .[[1]]
  
  