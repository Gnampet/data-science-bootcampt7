
# Book to Scrape website is the website that was especially made for web scarping.

#=================================================================================

# Read html
url_book <- "http://books.toscrape.com/"
url_book <- read_html(url_book)

# Select interesing topics in website
title <- url_book%>%
        html_elements("a")%>%
        html_attr("title")%>%
        na.omit()

price <- url_book%>%
        html_elements("p.price_color")%>%
        html_text2()

# Create data frame
book_web <- data.frame(title,price)
book_web
