library(ggplot2)

# The diamonds data set ####
#View(diamonds)
# carat — This is the weight of a diamond
# cut — This is the quality of the diamond cut; Fair, Good, Very Good, Premium, Ideal.
# color — The color of a diamond from D (best) to J (worst).
# clarity — a measurement of how clear the diamond is; I1 (worst), SI2, SI1, VS2, VS1, VVS2, VVS1, IF (best).
# depth — total depth percentage = z / mean(x, y) = 2 * z / (x + y) (43–79)
# width — width of the top of the diamond relative to the widest point (43–95).
# x — length of diamond in mm
# y — width in mm
# z — depth in mm


# Structure of ggplot ####

ggplot(data = diamonds,
       mapping = aes(
         x = cut,
         y = price
       ))

# Bar-plots ####

ggplot(data = diamonds, 
       mapping = aes(
         x = cut
       )) +
  geom_bar()

## Bar-plots with fill ####
ggplot(data = diamonds, 
       mapping = aes(
         x = cut,
         fill = cut
       )) +
  geom_bar()

## Horizontal bar-plot ####

ggplot(data = diamonds, 
       mapping = aes(
         y = clarity,
         fill = clarity
       )) +
  geom_bar()

### the same plot (Horizontal bar-plot) ####

ggplot(data = diamonds, 
       mapping = aes(
         x = clarity,
         fill = clarity
       )) +
  geom_bar() +
  coord_flip()

## Stacked bar plots ####

ggplot(data = diamonds,
       mapping = aes(
         x = cut, 
         fill = color)) +
  geom_bar()


## Grouped bar plots ####

ggplot(data = diamonds,
       mapping = aes(
         x = cut, 
         fill = color)) +
  geom_bar(position = "dodge")

# Box-plots ####

ggplot(data = diamonds,
       mapping = aes(
         x = cut,
         y = price
       )) +
  geom_boxplot()

## Box-plot with fill ####

ggplot(data = diamonds,           
       mapping = aes(
         x = cut,
         y = price,
         fill = cut)) + 
  geom_boxplot()

# Scatter plots ####

ggplot(data = diamonds,           
       mapping = aes(
         x = price,
         y = carat)) + 
  geom_point()

ggplot(data = diamonds,           
       mapping = aes(
         x = price,
         y = carat,
         colour = depth)) + 
  geom_point() + 
  scale_colour_viridis_b("magma")

# Histograms ####

ggplot(data = diamonds, 
       mapping = aes(x = price)) +
  geom_histogram(bins = 1000)


# The economics data set ####
View(economics)
# date — the month of data collection
# pce — personal consumption expenditures in billions of dollars
# pop — total population in thousands
# psavert — personal savings rate
# unempmed — median duration of unemployment in weeks
# unemploy — number of unemployed in thousands

# Line graphs ####

ggplot(data = economics, 
       mapping = aes(
         x = date,
         y = pop)) +
  geom_line()

# Labeling ####

ggplot(data = economics, 
       mapping = aes(
         x = date,
         y = pop)) +
  geom_line() +
  ggtitle("Population of the United States from 1967 - 2015") +
  xlab("Date") +
  ylab("Population")

# Faceting #### 

ggplot(data = diamonds, 
       mapping = aes(x = cut,
                     fill = cut)) +
  geom_bar() +
  facet_wrap(color ~ .)


ggplot(data = diamonds, 
       mapping = aes(x = cut,
                     fill = cut)) +
  geom_bar() +
  facet_grid(color ~ .)
