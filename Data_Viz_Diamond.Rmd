# Hello World

This project is part of my homework in the data science boot camp 7 by Data Rockie to explore the diamond data set by creating a visualization.

##  Load required package
Firstly, installing and loading the necessary packages are required. In this case, I have installed the package in my Rstudio.  
```{r}
library(tidyverse)
library(corrplot) # for matrix graph
```
## Explore data frame
Check basic information about data: column names, no. of observation, data type, formatting and missing values.
```{r}
glimpse(diamonds)
head(diamonds)
which(is.na(diamonds))
```
### Data Summary
1. There are 53,940 observations.
2. There are no missing value.

# Explore visualization

Check the relationship between the column that have a numeral number.

```{r}
num <- diamonds%>%
  select(carat,
         price,
         depth,
         table,
         x,
         y,
         z)
corrplot(cor(num), method = "color", type = "upper", addCoef.col =  "red", col = COL2("RdYlBu"))
```
1.There is a positive correlation of carat with x, y, and z, indicating an increase in carat might predict an increase in the size or weight of the diamond.

2.There is also a positive correlation of the price with the carat, x, y, and z, indicating that an increase in carat, x, y, and z is an increase in the price.

3.there is a negative correlation between the depth and the table, indicating that an increase in the depth predicts a decrease in the table.

Check the relationship between price and carat.
```{r}
set.seed(42)
ggplot(diamonds%>% sample_n(30000),aes(carat,price))+
  geom_point(alpha = 0.5, col = "salmon")+
  geom_smooth()+
  theme_minimal()+
  labs(title = "Relationship between price and carat",
       subtitle = "Sample 30,000 observations")
```

Example of the price and the carat relationship, 30,000 observations indicate a positive correlation, an increase of the carat also does to the price.

Now, let’s check the relationship between the price with the ordered factor which is the cut, color, and clarity. For this exploration, I will set 30,000 observations the same as the “Relationship between price and carat” visualization, and use set.seed() to guarantee the same random value every time running the code.
```{r}
set.seed(42)
median_cut <- diamonds %>%
  sample_n(3000)%>%
  group_by(cut) %>%
  summarise(median = median(price))

  ggplot(diamonds %>% sample_n(30000),aes(cut, price, color = cut)) +
  geom_boxplot(alpha = 0.4) +
  labs(title = "Price of diamonds by their cut") +
  geom_text(data = median_cut, aes(cut, median, label = median), 
            position = position_dodge(width = 0.8), size = 4, vjust = -0.5)
```

As you can see, the premium cut has the highest median of 3320.5 prices followed by the fair cut, and then the good cut, very good cut, and ideal cut.

```{r}
set.seed(42)
median_color <- diamonds %>%
  sample_n(3000)%>%          
  group_by(color) %>%
  summarise(median = median(price))

  ggplot(diamonds %>% sample_n(30000),aes(color, price, color = color)) +
  geom_boxplot(alpha = 0.4) +
  labs(title = "Price of diamonds by their color") +
  geom_text(data = median_color, aes(color, median, label = median), 
            position = position_dodge(width = 0.8), size = 4, vjust = -0.5)
```

This part indicates J color which is the lowest grade of color from the highest grade is 'D' to 'J' has the highest median of 4192 prices followed by the H color and then the I, F, G, D, and E colors.

```{r}
set.seed(42)
median_clarity <- diamonds %>%
  sample_n(3000)%>%
  group_by(clarity) %>%
  summarise(median = median(price))

  ggplot(diamonds%>%sample_n(30000),aes(clarity, price, color = clarity)) +
  geom_boxplot(alpha = 0.4) +
  labs(title = "Price of diamonds by thier clarity") +
  geom_text(data = median_clarity, aes(clarity, median, label = median),
            position = position_dodge(width = 0.8), size = 4, vjust = -0.5)

```

This part indicates SI2 has the highest median of 4123 prices followed by I1 of 3139 prices, SI1 of 2809 prices then followed by VS2, VS1, IF, VVS1, and VVS2. From 8 clarity of the diamond SI2 and S1 which have the lowest grade as a flaw have higher prices than IF, VVS1, and VVS2 which have almost the highest grade.

## Conclusion
From exploring the diamonds data set I have divided the data into two parts the numeral and ordered parts. In the first part, I created the matrix visualization to explore the correlation between the numerical factor, in the second I explored the relationship of the price with each category factor.

This resulted in the strong positive relationship of price with carat, x, y, and z which means the higher carat, bigger size, and more weight of the diamond tends to have a high price. 
