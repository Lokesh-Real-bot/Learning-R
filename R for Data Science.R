# ----- Project Starts ----

# This R project contains the codes (examples), models and explanations 
# From the book "R For Data Science" by Hadley Wickham and Garret Grolemund
# And some help and info. from google searches.

# Specifically using the packages tidyverse (ggplot2, tibble, tidyr, readr, purr and dplyr)
# Other Packages nycflights13, gapminder, lahman

# Loading the package
library(tidyverse)

# basics of data

# 1. Categorical variables contain a finite number of categories or distinct groups.
# Categorical data might not have a logical order. 
# For example, categorical predictors include gender, material type, and payment method.
 
# 2. Discrete variables are defined only on a finite set or a countably infinite set. 
# Numeric variables that have a countable number of values between any two values. 
# For example, the number of customer complaints or the number of flaws or defects.

# 3. Continuous variables are numeric variables that have an infinite number of values
# between any two values. A continuous variable can be numeric or date/time. 
# For example, the length of a part or the date and time a payment is received.

# R will interpret cty as a discrete rather than a continuous variable. 
# In R that’s called a factor. What happens is that for any unique number of city 
# miles per gallon that is in the data set we will get a separate facet. 
# This is not a very useful visualization of the data because in reality 
# very few cars have the same number of gallons.
# Faceting becomes difficult for continuous variable.

# Starting some minimal things with pre-installed data of cars of 38 models of cars
# A tibble of 134 rows cross 11 columns.
# displ= engine's size in litres.
# hwy = Car's fuel efficiency (miles per gallon (mpg))


# More About the data and explanation of the  variables (columns) and rows(observation).
?mpg

# Starting
mpg
view(mpg)

ggplot(data = mpg) + geom_point(mapping = aes(x=displ, y=hwy))
ggplot(mpg, aes(x=displ, y=hwy,)) + geom_point()

# The above visualization has two methods as shown.
# We cannot specify color specifically in second code along with aesthetics
# But we can differentiate variables using color.
# Like color according to size, drv etc
# We will get to know later.

# Coloring the plots specifically.
ggplot(data = mpg)+ geom_point(mapping = aes(x=displ,y=hwy), color="Blue")
ggplot(mpg, aes(x=displ, y=hwy))+geom_point(colour="Blue")

# Stroke 
# The stroke argument is used to control the size of the edge/border of your point.
# If we say it differently it changes the size of the border for shape.
ggplot(data = mpg)+ geom_point(mapping = aes(x = displ, y = hwy),
             shape = 15,
             colour = "green",
             stroke = 3)

#For the shapes from 14 - 21 the size and stroke arguments does almost the same.
ggplot(data = mpg)+geom_point(mapping = aes(x = displ, y = hwy),
             colour = "green",
             shape = 15,
             size = 3)


#  The plot shows a negative relationship between engine size (displ)
# and fuel efficiency (hwy). However their are some outliers too.
# Let's see the outliers later.

# Which variables in mpg are categorical? Which variables are continuous?
# Description "?mpg" OR
# dataframe/tibble shows : integers and floating numbers = Continous, rest = categorical


# Facets
#  Another way,particularly useful for categorical variables, 
# is to split your plot into facets, 
# subplots that each display one subset of the data.

# Faceting the plots according to class
ggplot(data=mpg) + geom_point(mapping=aes(x=displ,y=hwy)) + 
  facet_wrap(~class)
ggplot(data=mpg) + geom_point(mapping=aes(x=displ,y=hwy)) + 
  facet_wrap(~class, nrow=2)

# facet your plot on the combination of two variables
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy))+
  facet_wrap(class~drv)
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy))+
  facet_grid(class~drv)

# The combined data shows that most SUVs are 4wd. 
# giving you maximum control and traction when 
# tackling off-road challenges like rocks, dirt, or snow.
# however SUVs with bigger engine size have rear wheel drive

# If you see carefully grid shows better info.
#If you prefer to not facet in the rows or columns dimension, use a .
#instead of a variable name
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy))+
  facet_grid(class~.)
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy))+
  facet_grid(.~drv)

# Trying Different Geoms.
ggplot(data=mpg)+geom_smooth(mapping=aes(x=displ,y=hwy))
ggplot(data=mpg)+geom_line(mapping = aes(x=displ,y=hwy))

#Changes in geoms using a aesthetic criteria.
# Criteria as mention earlier is put along with aes.
# Shaping according to drv
# Linetype according to drv
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy, shape = drv))
ggplot(data=mpg)+geom_smooth(mapping=aes(x=displ,y=hwy, linetype = drv))
ggplot(data=mpg)+geom_smooth(mapping=aes(x=displ,y=hwy, linetype = drv), 
                             show.legend = FALSE)

# However, not every aesthetic works with every geom.
# You could set the shape of a point, but you couldn’t set the “shape” of a line.

# See the difference between 2 codes shown below.
ggplot(data=mpg)+geom_smooth(mapping=aes(x=displ,y=hwy, color = drv))
ggplot(data=mpg)+geom_smooth(mapping=aes(x=displ,y=hwy), color = "Red")

# To display multiple geoms in the same plot, add multiple geom functions 
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy))+
  geom_smooth(mapping = aes(x=displ,y=hwy))

# global mappings that apply to each geom in the graph.
ggplot(data=mpg, mapping = aes(x=displ,y=hwy))+
  geom_point()+
  geom_smooth()

# overwrite the global mappings for that layer only
ggplot(data=mpg, mapping = aes(x=displ,y=hwy))+
  geom_point(mapping = aes(colour = class))+
  geom_smooth()

# overwrite the data for that layer only.
ggplot(data=mpg, mapping = aes(x=displ,y=hwy))+
  geom_point()+
  geom_smooth(data = filter(mpg, class=="subcompact"))

# Removing Confidence Interval. se=FALSE
# By default, it is the 95% confidence level interval for predictions.
ggplot(data=mpg, mapping = aes(x=displ,y=hwy))+
  geom_point()+
  geom_smooth(data = filter(mpg, class=="subcompact"), se=FALSE)

# 99% CI instead of a 95% 
ggplot(data=mpg, mapping = aes(x=displ,y=hwy))+
  geom_point()+
  geom_smooth(data = filter(mpg, class=="subcompact"), level=0.99)
