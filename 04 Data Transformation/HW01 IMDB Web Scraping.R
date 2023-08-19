
# IMDB web scraping in R Programming Language
# Hello! I will show you how to pull data from the static website by using R programming language

#==============================================================================================

# First install a required package
library("rvest") # for web scraping in r
library("tidyverse") # for transforms data

# Read HTML
url <- "https://www.imdb.com/search/title/?groups=top_100&sort=user_rating,desc"
url <- read_html(url)

# Select the topic you need on the website and assign value name
movie_name <- url %>% 
            html_nodes("h3.lister-item-header") %>% 
            html_text2()

rating <- url %>% 
        html_elements("div.ratings-imdb-rating") %>% 
        html_text2() %>% as.numeric() 

votes <- url %>%
        html_elements("p.sort-num_votes-visible") %>%
        html_text2()

genre <-url %>%
        html_elements("span.genre")%>%
        html_text2()

runtime <-url %>%
        html_elements("span.runtime")%>%
        html_text2()%>%
        str_extract("\\d+")%>%
        as.numeric() 

metrascore <- url %>%
            html_elements("span.metascore")%>%
            html_text2() %>%
            as.numeric()

# Created data frame
df <- data.frame(movie_name, genre, runtime, rating, metrascore, votes)

# Cleaning data
cleaning_1 <-df %>% 
            separate(votes,sep = " \\| " , into = c("votes", "gross", "tops"), remove = TRUE)

# Replace value 
cleaning_1$gross[c(9,21,31,33,47)] <- c("NA","NA","NA","NA","NA")
cleaning_1$tops[c(9,21,31,33,47)] <- c("Top 250: #15","Top 250: #31","Top 250: #21","Top 250: #47", "Top 250: #46")

# Separate column by delimiter
cleaning_2 <- cleaning_1 %>% 
    separate(votes, sep = "\\:", into =c("votes_h", "votes"))
cleaning_3 <- cleaning_2 %>% 
                separate(gross, sep = "\\:", into = c("gross_h", "gross") )
cleaning_4 <- cleaning_3 %>% 
            separate(tops, sep = "\\:", into = c("tops_h", "tops") )
cleaning_5 <- cleaning_4 %>% 
            separate(movie_name, sep = "\\.", into =c("no", "name"))
cleaning_6 <- cleaning_5 %>% 
            separate(name, sep = "\\(", into =c("name", "year"))
cleaning_7 <- cleaning_6 %>% 
            separate(year, sep = "\\)", into ="year") 
# This is not a good way to clean data because I have repeated the same step several times.

# remove the column and assign value back to the data frame
imbd_df <- cleaning_7[,!names(cleaning_4) %in% c("votes_h","gross_h","tops_h")]

# write data into a CSV file
write_csv(imbd_df,"imdb.csv")
