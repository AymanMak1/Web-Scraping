library(rvest)
library(dplyr)
library(xml2)

# Using SelectorGadget

  link = "https://myanimelist.net/"
  page = read_html(link)
  
  animetitle = page %>% html_nodes("h3.latest_updated_h3 a") %>% html_text
  anime_links = page %>% html_nodes("h3.latest_updated_h3 a") %>% 
    html_attr("href") 
  
  # %>% paste("https://myanimelist.net", ., sep="")
  
  get_infos = function(anime_link) {
      anime_link="https://myanimelist.net/anime/40748/Jujutsu_Kaisen_TV"
      anime_page = read_html(anime_link)
      score = anime_page %>% html_nodes(".score-label") %>% html_text
      ranking = anime_page %>% html_nodes(".numbers.ranked strong") %>% html_text
      popularity = anime_page %>% html_nodes(".numbers.popularity strong") %>% html_text
      members = anime_page %>% html_nodes(".numbers.members strong") %>% html_text
      anime_infos = data.frame(score,ranking,popularity,members)
      return(anime_infos)
  }
  
  infos = sapply(anime_links, FUN = get_infos)
  animetitle
  
  anime_infos = data.frame(animetitle,infos)
  