# ----- Project Starts ----

# This R project contains the codes (examples), models and explanations 
# From the book "R For Data Science" by Hadley Wickham and Garret Grolemund
# And some help and info. from google searches and Chatgpt.

# Specifically using the packages tidyverse (ggplot2, tibble, tidyr, readr, purr, magrittr and dplyr)
# Other Packages nycflights13, gapminder, lahman etc.

# Not Doing Parsing or importing a dataset in this as it may affect my saved codes.
# Will do it separately

# Not Doing Complex nested capture groups or complex regular expressions for now.

# Also skipped the chapter 'Many Models with purrr and broom' and chapters related to R Markdown.
# Will do after finishing another book of predictive modelling to understand
# models better.


# I am aware that I should avoid comments that explain the “what” or the “how.”
# And should focus more on why but since its a learning project,
# They are used continuously.

# I have tried my best to keep it understandable for future me and for others with no coding errors.
# But you know Murphy's Law, Its not Perfect.

# Operators and Assignrment
x <- seq(1,10)
x

x <- seq(1,10, length.out=5)
x

# Loading the package
library(tidyverse)

# basics of data

# 1. A variable is categorical if it can only take one of a small set of values
# Categorical data might not have a logical order. 
#  In R, categorical variables are usually saved as factors or character vectors. 
# For example, categorical predictors include gender, material type, and payment method.
# Bar chart represnts them good for 1 dimesnion
# boxplots for 2 categorical variables
 
# 2. Discrete variables are defined only on a finite set or a countably infinite set. 
# Numeric variables that have a countable number of values between any two values. 
# For example, the number of customer complaints or the number of flaws or defects.

# 3.  A variable is continuous if it can take any of an infinite set of ordered
# values. A continuous variable can be numeric or date/time. 
# For example, the length of a part or the date and time a payment is received.
# Histogram, geom_freqpoly rpresents them good for 1 dimension
# geom_bin2d() and geom_hex() to bin 2 continuous variable.

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


#------- Diamond Data -------
library(tidyverse)

install.packages("Stat2Data")
library(Stat2Data)

diamonds
view(diamonds)

#-----bar Charts------

#Unfortunately when people talk about bar #charts casually, 
#they might be referring to bar chart,
#where the height of the bar is already present in the data, or the
#previous bar chart where the height of the bar is generated by
#counting rows. 

# But here in data there is no such info. How will we approach ?
# Lets First understand.


# 1. graphs, like scatterplots, plot the raw values of your dataset. 

# 2. Smoothers fit a model to your data and then plot predictions from the model.

# 3. Boxplots compute a robust summary of the distribution and 
# display a specially formatted box

# 4. Bar charts, histograms, and frequency polygons bin your data 
# and then plot bin "counts", the number of points that fall in each bin.
# Basically it plots new values.


# The algorithm used to calculate new values for a graph is called a stat, 
# short for statistical transformation.


ggplot(data=diamonds)+geom_bar(mapping = aes(x=cut))
# We didnt put y variable as it came as default and here its "count"

# Every geom uses a stat argument as its default value.
# Every stat has a geom as its default plot

# Reciprocately the stat_argument can be used to plot the geom.
ggplot(data=diamonds)+stat_count(mapping = aes(x=cut))


# override the default stat
# The stat = “identity” argument in ggplot2 is used 
# when you want to ensure that the values that are plotted on the x and y axes 
# are identical, as opposed to being transformed by a statistical transformation 

# Create a tribble
# The tribble() function is particularly useful for creating small datasets 
# for examples and testing.

demo <- tribble(
  ~a, ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40
)

ggplot(data=demo)+geom_bar(mapping = aes(x=a,y=b), stat = "identity")

# Tribble vs tibble, we will learn later.

ggplot(data=diamonds)+geom_bar(mapping = aes(x=cut,y=carat), stat = "identity")


# Coloring acc to variables.
ggplot(data=diamonds)+geom_bar(mapping = aes(x=cut,colour = cut))
ggplot(data=diamonds)+geom_bar(mapping = aes(x=cut, fill=cut))

# Previously both the variables were same for x axis and color/fill.

# 2 variables will create a stack automatically
ggplot(data=diamonds)+geom_bar(mapping=aes(x=cut, fill=clarity))

# If we dont want a stacked bar we can use 
# position ="identity", position ="dodge", position ="fill"

# 1. Posittion = "identity"
# However identity argumnent is less useful for bars because it overlaps
# To see that overlapping we either need to make the bars slightly transparent 
ggplot(data=diamonds)+geom_bar(mapping=aes(x=cut, fill=clarity), 
                               position = "identity")

ggplot(data=diamonds)+geom_bar(mapping=aes(x=cut, fill=clarity), 
                               position = "identity", alpha=1/5)

ggplot(data=diamonds)+geom_bar(mapping=aes(x=cut, color=clarity),
                               position="identity")

ggplot(data=diamonds)+geom_bar(mapping=aes(x=cut, color=clarity),
                               position="identity", fill=NA)


# 2. position="fill'
# works like stacking, but makes each set of stacked bars the same height. 
# This makes it easier to compare proportions across groups:
ggplot(data=diamonds)+geom_bar(mapping = aes(x=cut, fill=clarity),
                               position = "fill")

# 3. "Dodge"
# "dodge" places overlapping objects directly beside
# one another. This makes it easier to compare individual values:

ggplot(data=diamonds)+ geom_bar(mapping = aes(x=cut, fill=clarity),
                                position = "dodge")


# 4. Jitter
# This position is also not suitable for bar charts.
# But useful for scatter plots

ggplot(data = mpg) + geom_point(mapping = aes(x=displ, y=hwy))

# Notice that plot displays only 126 points, even though
# there are 234 observations in the dataset. 
# many points overlap each other. This problem is known as overplotting. 
# "jitter" adds a small amount of random noise to each point. 
# This spreads the points out
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy),
                            position = "jitter")


# ------Stat Summary---

# summarizes the y values for each unique x value, to draw attention to the summary 

# we use the fun argument within stat_summary() to specify the summary function to use 
# and we use the geom argument to specify the geometric shape to use in the plot.


?stat_bin

ggplot(data=diamonds) +
  stat_summary(
    mapping = aes(x=cut,y=depth),
    fun.ymin = min,
    fun.ymax= max,
    fun.y=median
  )


#----- Coordinate Systems-----
library(tidyverse)

#The default coordinate system is the Cartesian coordinate
#system where the x and y position act independently to find the
#location of each point.

# 1.  coord_flip()
# This is useful (for example) if you want horizontal boxplots.

ggplot(data = mpg)+geom_boxplot(mapping = aes(x=class,y=hwy))
ggplot(data=mpg, mapping = aes(x=class,y=hwy))+geom_boxplot()

ggplot(data=mpg,mapping = aes(x=class,y=hwy))+geom_boxplot()+coord_flip()

# 2. coord_quickmap()
# sets the aspect ratio correctly for maps. 

#the coord_map() projects a portion of the earth, 
# which is approximately spherical, onto a flat 2D plane
# Map projections do not, in general, preserve straight lines, 
# so this requires considerable computation.

# coord_quickmap() is a quick approximation that does preserve straight lines.

install.packages("maps")
library(maps)

install.packages("mapproj")
library(mapproj)

map_data("nz")
view(map_data("nz"))

map_data("usa")
view(map_data("usa"))

# plotting the maps
nz <- map_data("nz")
ggplot(data=nz, mapping = aes(x=long,y=lat, group = group))+
  geom_polygon(fill="white", color="black")

ggplot(nz, mapping = aes(long,lat, group = group))+
  geom_polygon(fill="white", color="black")

ggplot(nz, mapping = aes(long,lat, group = group))+
  geom_polygon(fill="white", color="black")

ggplot(nz, mapping = aes(long,lat, group = group))+
  geom_polygon(fill="white", color="black")+coord_map()

# notice the grid change
ggplot(nz, mapping = aes(long,lat, group = group))+
  geom_polygon(fill="white", color="black")+coord_quickmap()

# 3, coord_polar() 
# It uses polar coordinates. 
# Polar coordinates revea an interesting connection between 
# a bar chart and a Coxcomb chart

ggplot(diamonds)+geom_bar(mapping = aes(x=cut, fill = cut), show.legend = FALSE)

# theme
ggplot(diamonds)+geom_bar(mapping = aes(x=cut, fill = cut), show.legend = FALSE)+
 theme_dark()

ggplot(diamonds)+geom_bar(mapping = aes(x=cut, fill = cut), show.legend = FALSE)+
  theme_classic()

ggplot(diamonds)+geom_bar(mapping = aes(x=cut, fill = cut))+
  theme_classic()+theme(legend.position = "top")

ggplot(diamonds)+geom_bar(mapping = aes(x=cut, fill = cut), show.legend = FALSE)+
  theme(aspect.ratio = 1)

ggplot(diamonds)+geom_bar(mapping = aes(x=cut, fill = cut), show.legend = FALSE, width=1)+
  theme(aspect.ratio = 1)

ggplot(diamonds)+geom_bar(mapping = aes(x=cut, fill = cut), show.legend = FALSE, width=0.5)+
  theme(aspect.ratio = 1)


ggplot(diamonds)+geom_bar(mapping = aes(x=cut, fill = cut), show.legend = FALSE, width=5)+
  theme(aspect.ratio = 1)


# Normally we use xlab and ylab along with plots
# ggplot2 has labs function.
ggplot(diamonds)+geom_bar(mapping = aes(x=cut, fill = cut), show.legend = FALSE)+
  labs(x=NULL,y=NULL)

# theme aspect raio =1 
# This sets the physical aspect ratio of the entire plot panel
# It does not ensure equal scaling of the x- and y-axes.

ggplot(diamonds)+geom_bar(mapping = aes(x=cut, fill = cut), show.legend = FALSE)+
  theme(aspect.ratio = 1)+labs(x=NULL,y=NULL)

ggplot(diamonds)+geom_bar(mapping = aes(x=cut, fill = cut), show.legend = FALSE)+
  theme(aspect.ratio = 1)+labs(x=NULL,y=NULL)+coord_flip()


# Using coord_polar() 
ggplot(diamonds)+geom_bar(mapping = aes(x=cut, fill = cut), show.legend = FALSE, width=1)+
  theme(aspect.ratio = 1)+labs(x=NULL,y=NULL) + coord_polar()

# coord_fixed()
# The coord_fixed() function in ggplot2 is used to fix the aspect ratio of the plot.
# By default, the aspect ratio is not fixed, so the units on the x-axis and y-axis may differ. 
# coord_fixed() ensures that one unit on the x-axis equals one unit on the y-axis.

ggplot(data=mpg, mapping = aes(x=cty,y=hwy))+geom_point()

ggplot(data=mpg, mapping = aes(x=cty,y=hwy))+geom_point()+coord_fixed()

# The geom_abline() function adds a straight line to a ggplot, defined by its slope and intercept.
# It is commonly used for reference lines, such as regression lines, y = x lines, 
# or any linear relationship you want to highlight.

ggplot(data=mpg, mapping = aes(x=cty,y=hwy))+geom_point()+coord_fixed()+
  geom_abline()

#--------- The Layered Grammar of Graphics-----

#  ggplot(data = <DATA>) +
#  <GEOM_FUNCTION>(
#   mapping = aes(<MAPPINGS>),
#   stat = <STAT>,
#   position = <POSITION>) +
#  <COORDINATE_FUNCTION> +
#  <FACET_FUNCTION>

#-----------:)-----------

# ----Object names----

#     i_use_snake_case
#     otherPeopleUseCamelCase
#     some.people.use.periods
#     And_aFew.People_RENOUNCEconvention

# --------- Data Transformation with dplyr--------

# create some new variables or summaries, or maybe
#you just want to rename the variables or reorder the observations in
#order to make the data a little easier to work with.

install.packages("nycflights13")
library(nycflights13)


flights
view(flights)

# 1. Filter()
#Pick observations by their values
# Used to subset "rows" based on "specified conditions"

# 2. arrange()
# Reorder the rows 
#  arrange() works similarly to filter() except that instead of selecting
# rows, it changes their order. 
#  It takes a data frame and a set of column names 
# (or more complicated expressions) to "order by"
#  If you provide more than one column name, each additional column will
# be used to break ties in the values of preceding columns
#  Use desc() to reorder by a column in descending order:. 

# 3. select()
# Pick variables by their "names"
# Used to subset or rearrange columns (variables)

# 4. Mutate()
# Create new variables with functions of existing variables
# Used to create or modify columns in a dataset.

# 5. Summarize()
# Provides a quick statistical summary of each column in a dataset
# it does not modify or subset the original data

filter(flights, month==1,day==1)

dec25 <-  filter(flights, month ==12,day==25)
dec25

#  There’s another common problem you might encounter when using
# ==: floating-point numbers.

(1/49)*49==1

# The answer came as false
# Computers remember that every number you see is an approximation. 
#  Instead of relying on ==, use near():
near(1/49*49, 1)

#  Logical Operators 
# and = "&"
# or = "|"
# not ="!"

# Piping :  %in% 
# It makes nested function easy to understand.

filter(flights, month==12 | month ==11)

filter(flights , month %in% c(11,12))

# !(x | y) is the same as !x & !y. 
# (De Morgan’s law: applicable)

filter(flights, !(arr_delay >120 | dep_delay >120))
filter(flights, arr_delay <=120, dep_delay <=120)         

# Missing Values
# almost any operation involving an unknown value (NA) will also be unknown (NA)
# To remove na values : na.rm=TRUE

x<-NA
y<-NA
x==y

#  If you want to determine if a value is missing, use is.na():
is.na(x)
is.na(y)


# Arrange
year1 <- arrange(flights, month)
year1
view(year1)

year2 <- arrange(flights, desc(month))
year2
view(year2)

# Select()
Date1 <- select(flights, year, month, day)
Date1

Date2 <- select(flights, year:day)
Date2

small_data <- select(flights, 
              year:day,
              distance,
              air_time)
small_data


#  mutate()
# speed = distance/air_time
# Converting air time in hours

mutate(small_data,
       speed =distance/(air_time*60))

# Transmute
#  If you only want to keep the new variables, use transmute().
transmute(small_data,
          speed=distance/(air_time*60))
transmute(flights,
          distance,
          air_time,
          speed=distance/air_time*60)

#  Modular arithmetic (%/% and %%)
# integer division %/% and Remainder %%
# break integers into pieces. 

transmute(flights,
          dep_time,
          hour=dep_time %/% 100,
          minute = dep_time %% 100)


#Offsets, lead() and lag() 
# This allows you to compute running differences (e.g., x - lag(x))
# or find when values change (x != lag(x)). 

x <- seq(1:10)
x

lag(x)
lead(x)

x-lag(x)

#  Cumulative and rolling aggregates
# cumsum(), cumprod(), cummin(), cummax()

x <- seq(1:10)
x

cumsum(x)
cummean(x)

# Adding examples.
# It adds like a matrix.
# Adds adjacent numbers
1:3 + 1:10 #will not add
2:6 + 8:12 #will add because both seq have same digits i.e. 5

# 5. Group_by
# If you provide more than one column name, each additional column will
# be used to break ties in the values of preceding columns
# For example we want to group by day we cannot put only day column as 
# 1 day can be found for different months and year.
# So we will give a seq of columns : year, month, day

by_day <- group_by(flights, year, month, day)
by_day

# Notice the result looks almost identical to the original data frame, 
# but if you inspect it (e.g., with str(grouped_data)), 
# you'll notice that it has additional grouping information.
# This is because column data is changed and cant be put in the samee column

# To see the result
# Group-specific operations require additional functions
# Filter, mutate or summarize etc
# and create a new column for grouped data.

# 6.  summarize
summarise(by_day, total_days =sum(day))
# This tells that we have 842 flights operational on 01/01/2013.

# Deriving average departure delay for each day.
summarise(by_day, Average_delay = mean(dep_delay, na.rm=TRUE))


# Combining Multiple Operations with the Pipe.
#  distance and average delay for 'each location'. 

library(tidyverse)
library(nycflights13)
flights
view(flights)

# How many destinations are there ?
delays <- flights %>% 
  group_by(dest) %>%
  summarise(count=n())

delays

delays2 <- flights %>%
  group_by(dest) %>%
  summarise(
    count=n(),
    dist = mean(distance, na.rm=TRUE),
    delay = mean(arr_delay, na.rm=TRUE)
  )

delays2


delays3 <- flights %>%
  group_by(dest) %>%
  summarise(
    count=n(),
    dist = mean(distance, na.rm=TRUE),
    delay = mean(arr_delay, na.rm=TRUE)
  ) %>%
filter(count>20, dest !="HNL")

delays3


# Missing Values 
# if there’s any missing value in the input, the output will be a missing value.
flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay, na.rm=TRUE))


#  In this case, where missing values represent cancelled flights, we
# could also tackle the problem by first removing the cancelled flights.

not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

#  Counts
# Whenever you do any aggregation, it’s always a good idea to include
# either a count (n()), or a count of nonmissing values
# (sum(!is.na(x))).

# That way you can check that you’re not drawing
# conclusions based on very small amounts of data.

# Average delays by tailnum
delays4 <- not_cancelled %>%
  group_by(tailnum) %>%
  summarise(average_delay=mean(arr_delay))

delays4
ggplot(data=delays4, mapping = aes(x=average_delay))+
  geom_freqpoly()

# are some planes that have an average delay of 5 hours (300 minutes)
# Most planes havee a delay arond -50 to 100 minutes

delays5 <- not_cancelled %>%
  group_by(tailnum) %>%
  summarise(average_delay=mean(arr_delay),
            count=n())

delays5

ggplot(data=delays5, mapping = aes(x=count, y=average_delay))+
  geom_point()
ggplot(data=delays5, mapping = aes(x=count, y=average_delay))+
  geom_point(alpha=1/10)

# Notice that 200-300 minutes delays are few in number.
# it’s often useful to filter out the
# groups with the smallest numbers of observations, so you can see
# more of the pattern and less of the extreme variation in the smallest groups.

delays5 %>%
  filter(count>25) %>%
  ggplot(mapping = aes(x=count, y=average_delay))+
  geom_point(alpha=1/10)


#  Let’s look at how the average performance of batters in baseball 
# is related to the number of times they’re at bat.
install.packages("Lahman")
library(Lahman)

Batting
str(Batting)

# Converting the dataframe to tibble.
batting <- as.tibble(batting)
str(batting)
view(batting)

?Batting
# ab = at bats 
# h = hits

#  skill of the batter 
# Hits (H) against the number of opportunities to play balls (ab)


batters <- batting %>%
  group_by(playerID) %>%
  summarise(
    skill=sum(H,na.rm = TRUE)/sum(AB, na.rm = TRUE),
    opportunities =sum(AB, na.rm=TRUE)
  )
batters

batters %>%
  filter(opportunities>100) %>%
  ggplot(mapping = aes(x=opportunities, y=skill))+
  geom_point()+geom_smooth()

batters %>%
  filter(opportunities>100) %>%
  ggplot(mapping = aes(x=opportunities, y=skill))+
  geom_point(alpha=1/10)+geom_smooth(se=FALSE)

# If you naively sorton desc(ba),
# the people with the best batting averages are clearly lucky, not skilled:

batters %>%
  arrange(desc(skill))

#  combine aggregation with logical subsetting. 
not_cancelled %>%
  group_by(year,month,day) %>%
  summarise(
    # average delay
    avg_delay1 = mean(arr_delay),
    # average positive delay
    avg_delay2 = mean(arr_delay[arr_delay>0])
  )

# Measures of spread
# 1. sd : The mean squared deviation, standard deviation for
# 2. IQR : The interquartile range
# 3. mad :  median absolute deviation

view(not_cancelled)

not_cancelled %>%
  group_by(dest) %>%
  summarise(distance_sd = sd(distance))%>%
  arrange(desc(distance_sd))


# Why is distance to some destinations more variable
# than to others?

# Measures of rank
# 1.  min(x), 
# 2. quantile(x, 0.25) : will find a value of x that is greater than 25% of
# the values, and less than the remaining 75%
# 3. max(x)

#  When do the first and last flights leave each day
not_cancelled %>%
  group_by(year,month,day)%>%
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

# Measures of position 
# first(x), nth(x, 2), last(x)

not_cancelled %>%
  group_by(year,month,day) %>%
  summarise(
    first_dep = first(dep_time),
    last_dep = last(dep_time)
  )

# Count (n)
not_cancelled %>%
  group_by(dest)%>%
  summarize(carriers = n(carrier))%>%
  arrange(desc(carriers))
# It will give error
  
# # To count the number of distinct (unique) values, use n_distinct(x):

not_cancelled %>%
  group_by(dest)%>%
  summarize(carriers = n_distinct(carrier))%>%
  arrange(desc(carriers))

# weight variable. 
# For example, you could use this to “count” (sum) 
# the total number of miles a plane flew:
not_cancelled %>%
  count(tailnum, wt=distance)

# What proportion of flights are delayed by more
# than an hour?
not_cancelled %>%
  group_by(year,month,day) %>%
  summarise(hour_perc = mean(arr_delay>60))

# Grouping by Multiple Variables
# When you group by multiple variables, each summary peels off one
#level of the grouping. That makes it easy to progressively roll up a dataset:

daily <- group_by(flights, year, month, day)

per_day <- summarise(daily, flights=n())
per_day

per_month <- summarise(per_day, flights=sum(flights))
per_month

per_year <- summarise(per_month, flights=sum(flights))
per_year


#  Ungrouping

daily %>%
  ungroup() %>%
  summarise(flights=n())

#---- Grouped Mutates (and Filters)----
# Grouping is most useful in conjunction with summarize(), but you
# can also do convenient operations with mutate() and filter():

flights %>%
group_by(year, month, day) %>%
  filter(arr_delay<10)


flights %>%
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay))<10)

popular_destinations <- flights %>%
  group_by(dest) %>%
  filter(n()>365)

popular_destinations

popular_destinations %>%
  filter(arr_delay>0) %>%
  mutate(prop_delay =arr_delay/sum(arr_delay)) %>%
  select(year:day, dest, arr_delay, prop_delay)

# Variation 
#  Variation is the tendency of the values of a variable to change from
# measurement to measurement. 
#  if you measure any continuous variable twice, you will get two different results.
# Each of your measurements will include a small amount of error 
# that varies from measurement to measurement.

# Categorical variables can also vary if you measure
# across different subjects (e.g., the eye colors of different people),

# The best way to understand that
# pattern is to visualize the distribution of variables’ values.

# Bar chart (x=cut, a categorical variable)
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut))

# Histogram (x=carat, a continuous variable)
ggplot(data=diamonds)+
  geom_histogram(mapping = aes(x=carat))

ggplot(data=diamonds)+
  geom_histogram(mapping = aes(x=carat), binwidth=0.5)

# almost 30,000 observations have a carat value between 0.25 and 0.75


# Zooming in just the diamonds with a size of less than three carats.
smaller <- diamonds %>%
  filter(carat <3)

ggplot(data=smaller, mapping = aes(x=carat)) +
  geom_histogram(binwidth = 0.1)

# geom_freqpoly
# instead of displaying the counts with bars, uses lines instead. 
# It’s much easier to understand overlapping lines.

ggplot(data=smaller, mapping = aes(x=carat))+
  geom_freqpoly()

ggplot(data=smaller, mapping = aes(x=carat, color=cut))+
  geom_freqpoly()

# tall bars show the common values of a variable, and 
# shorter bars show less-common values. 

# subgroups
#  clusters of similar values suggest that subgroups exist in your data
# 1. How are the observations within each cluster similar to each other?
# How are the observations in separate clusters different from  each other

ggplot(data=smaller, mapping = aes(x=carat))+
  geom_histogram(binwidth = 0.01)

# Ask questions
# 1.  Which values are the most common? Why?
# 2. Why are there more diamonds at whole carats and common fractions of carats?
# Why are there more diamonds slightly to the right of each peak
# than there are slightly to the left of each peak?
#  Why are there no diamonds bigger than 3 carats?

# Unusual Values
#  Outliers are observations that are unusual; data points that don’t seem to fit the pattern. 

diamonds
ggplot(data=diamonds, mapping = aes(x=y))+ geom_histogram(binwidth = 0.5)

#  evidence of outliers is the unusually wide limits on the y-axis:
#  There are so many observations in the common bins that the rar bins are 
# so short that you can’t see them There are so many observations in the 
# common bins that the rare bins are so short that you can’t see them

# Zooming In more
ggplot(data=diamonds, mapping = aes(x=y))+
  geom_histogram(binwidth = 0.5) +
  coord_cartesian(ylim = c(0,50))

# We notice some data at arond 0,35, 60
# Pluckking out the outliers

unusual <- diamonds %>%
  filter(y<3 | y>20) %>%
  arrange(y)

unusual

#  it’s reasonable to replace them with missing
# values and move on. However, if they have a substantial effect on
# your results, you shouldn’t drop them without justification. You’ll
# need to figure out what caused them.

# We know that diamonds can’t have a width of 0mm, so these values must be incorrect.
# measurements of 32mm and 59mm are implausible: those diamonds are
# over an inch long, but don’t cost hundreds of thousands of dollars!


?between
# between(x, left, right)

# Dealing with outliers
# # 1. Drop the rows with outliers
# 2. Replace the outliers with NA

# Dropping
diamonds2 <- diamonds %>%
  filter(between(y,3,20))

# Replacing
diamonds2 <- diamonds %>%
  mutate(ifelse(y<3|y>20,NA,y))

ggplot(data=diamonds2, mapping = aes(x=x,y=y))+
  geom_point(na.rm=TRUE)


#------Covariation------
#  Covariation is the tendency for the values of two or more variables
# to vary together in a related way. 

#  let’s explore how the price of a diamond varies with its quality
# cut = quality
ggplot(data=diamonds, mappin=aes(x=price))+
  geom_freqpoly(mapping=aes(color=cut), binwidth=500)

# Default count is not very useful here.
# Because if one of the groups is much smaller than the others,
# it’s hard to see the differences in shape


# Density
# To make the comparison easier we need to swap what is displayed
# on the y-axis. Instead of displaying count, we’ll display density.
ggplot(data=diamonds, mapping = aes(x=price, y=..density..))+
  geom_freqpoly(mapping = aes(colour = cut), binwidth=500)

# Correcting the error of ..density..
ggplot(data=diamonds, mapping = aes(x=price, y=after_stat(density)))+
  geom_freqpoly(mapping = aes(colour = cut), binwidth=500) 

# Changed palette. "Set1", "Set2", "Dark2" etc
ggplot(data=diamonds, mapping = aes(x=price, y=after_stat(density)))+
  geom_freqpoly(mapping = aes(colour = cut), binwidth=500, size=0.8)+
  scale_color_brewer(palette = "Set1")

#  There’s something rather surprising about this plot—it appears that
# fair diamonds (the lowest quality) have the highest average price.


#------continuous variable broken down by a categorical variable----
# It refers to analyzing how the continuous variable's values vary across
# different categories defined by the categorical variable.

# This breakdown allows you to understand patterns or differences between groups
# that may not be apparent when you just look at the continuous variable in isolation.

# Let's say you're studying the income (continuous variable) of people, 
# and you break it down by gender (categorical variable).
# 1. The average income for males is higher than for females.

# Imagine you're analyzing the height of students across three different school
# types (public, private, and charter schools).
# 1. You might find that the average height of students in private schools is 
# higher than in public schools.
  

#------boxplot-----

# Another alternative to display the distribution of a continuous variable 
# broken down by a categorical variable.

# Percentage is a ratio of something out of 100
# Percentile is a measure of the position or rank of a value within a dataset.

# 1. IQR : interquartile range. 25th to 75th percentile.
# 2. Median :  In the middle of the box is a line that displays the median.
# 3. Outliers : observations that fall more than 1.5 times the IQR from 
# either edge of the box. 
# 4. Whisker :  A line that extends from each end of the box and
# goes to the farthest non-outlier point in the distribution.


# We Know
# 1.  a sense of the spread of the distribution
# 2. whether the distribution is symmetric about the median.
# 3. distribution is skewed to one side.


#  price by cut/quality using geom_box plot():
library(tidyverse)

ggplot(data=diamonds, mapp=aes(x=cut, y=price))+
  geom_boxplot()
 
# highway mileage varies across classes.
 ggplot(data=mpg, mapping = aes(x=class, y=hwy))+geom_boxplot()

# Reordering 
 ?reorder
 
 # x : categorical variable whose levels will be reordered.
 # X : determines the eventual order of that level.
 # Fun : Function o be applied to each subset of X determined by the levels of x.
 # ... : optional: extra arguments supplied to FUN
 
 # reorder class based on the median value of hwy:
 ggplot(data = mpg)+ 
   geom_boxplot(mapping = aes(x=reorder(class,hwy, FUN = median), y=hwy))
 
 
 ggplot(data = mpg)+ 
   geom_boxplot(mapping = aes(x=reorder(class,hwy, FUN = median), y=hwy))+
   coord_flip()

# ----Two Categorical Variables----
 
#  To visualize the covariation between categorical variables.
# you’ll need to 'count the number of observations' for each combination.
#  One way to do that is to rely on the built-in geom_count()

 # Cut vs color
 # Also stat_count != geom_count
view(diamonds)
 ggplot(data = diamonds) + 
   geom_count(mapping = aes(x = cut, y=color)) 
 
# The size of each circle in the plot displays how many observations
#  occurred at each combination of values.
 
?geom_tile 
 
 diamonds %>%
   count(color, cut) %>%
   ggplot(mapping = aes(x=color, y=cut))+
   geom_tile(mapping = aes(fill = n))
   
 # -----Two Continuous Variables----
 
 ggplot(data=diamonds)+
   geom_point(mapping = aes(x=carat, y=price))

 # Scatterplots become less useful as the size of your dataset grows,
 # because points begin to overplot, and pile up.
 
 ggplot(data=diamonds)+
   geom_point(mapping = aes(x=carat, y=price), alpha=1/10)

 ggplot(data=smaller)+
   geom_bin2d(mapping = aes(x=carat,y=price))

install.packages("hexbin")
library(hexbin)

ggplot(data = smaller) +
  geom_hex(mapping = aes(x = carat, y = price)) 

# bin one continuous variable so it acts like a categorical variable.
?cut_width
# cut_width(x, width), as used here, divides x into bins of width width.

ggplot(data=smaller, mapping = aes(x=carat,y=price))+
  geom_boxplot(mapping = aes(group = cut_width(carat,0.1)))

# However boxplots look roughly the same
# One way to show that is to make the width of the box
# plot proportional to the number of points with varwidth = TRUE.

ggplot(data=smaller, mapping = aes(x=carat,y=price))+
  geom_boxplot(mapping = aes(group = cut_width(carat,0.1)), varwidth = TRUE)

#  display approximately the same number of points in each bin.
ggplot(data=smaller, mapping = aes(x=carat,y=price))+
  geom_boxplot(mapping = aes(group=cut_number(carat,20)))

#---Patterns and Models---
#  Patterns in your data provide clues about relationships. 

?faithful
# 	eruptions : Eruption time in mins
# 	waiting : Waiting time to next eruption

faithful
view(faithful)

ggplot(data=faithful)+
  geom_point(mapping = aes(x=eruptions, y=waiting))

# Relationship:
#  longer wait times are associated with longer eruptions.

# If two variables covary, you can use the values of one
# variable to make better predictions about the values of the second.

# If the covariation is due to a causal relationship (a special case), then
# you can use the value of one variable to control the value of the second.

# Trying a model
# I diamonds data price is determined by cut and carat
# Removing the carat price relationship and
# visualizing the relation ship of cut and price.

library(modelr)

mod <- lm(log(price) ~ log(carat), data = diamonds)

diamonds2 <- diamonds %>%
  add_residuals(mod) %>%
  mutate(resid = exp(resid))

ggplot(data=diamonds2)+
  geom_point(mapping = aes(x=carat,y=resid))

#  relationship between cut and price—relative to their size,
# better quality diamonds are more expensive.

ggplot(data = diamonds2) +
  geom_boxplot(mapping = aes(x = cut, y = resid))


# Going less explicit
ggplot(data=faithful, mapping = aes(x=eruptions))+
  geom_freqpoly(binwidth=0.25)

ggplot(faithful, aes(eruptions))+
  geom_freqpoly(binwidth=0.25)

diamonds %>%
  count(cut,clarity)%>%
  ggplot(aes(clarity,cut, fill = n))+geom_tile()


# -------Tibble------

# Se  how it creates a rectangular data.
tibble(
  x=1:5,
  y=1,
  z=x^2+y
)

# Nonsyntactic names. using backticks.
 
tb <- tibble(
  `:)`="smile",
  ` `="space",
  `200`="number"
)
tb

#  For transposed tibble. we use "tribble"
tribble(
  ~x,~y,~z,
  "a",1,"q",
  "b",2,"s"
)

# tibble vs data-frame (Printing)
# 1. refined print method that shows only the first 10 rows, 
# and all the columns that fit on screen. Not overwhelming Console
# 2. In addition to its name, each column reports its type.

# tibble vs data-frame (Subsetting)
# 1. It allows subsetting through $ and [[]]

#------Tidy Data-------

# Looking at the below tables.

table1
# 4 columns with distinct str

table2
# 4 columns also with distinct str but have cases and population in same column.

table3
# 3 Columns. cases and populaation together.

table4a
# Year values came as headings.

#  There are three interrelated rules which make a dataset tidy:
#  1. Each variable must have its own column.
# 2. Each observation must have its own row.
# 3. Each value must have its own cell.

# Table1 is tidy.
# Working on tidy data

# Compute rate per 10,000
table1 %>%
  mutate(rate=cases/population * 10000)

#  Compute cases per year.

table1 %>%
  group_by(year) %>%
  summarise(n=sum(cases,na.rm=TRUE))

# wt = weights when counting the occurrences of a group.
table1 %>%
  count(year, wt=cases)

# Tidying the untidy Data 
# 1. figure out what the variables and observations are
# 2. One variable might be spread across multiple columns.
# 3. One observation might be scattered across multiple rows.
# To fix these problems, tidyr: gather()and spread()

# Using Gather()
# gather() makeswide tables narrower and longer (from 2 columns to one)
# Here column names are not names of variables, but values of a variable.
library(tidyverse)
table4a

?gather


# variable whose values form the column names are called key, YEAR (1999 and 2009)
# variable whose values are spread over the cells called VALUE, (number of cases (745, 26666 etc))
# “1999” and “2000” are nonsyntactic names so we have to surround them in backticks

table4a %>% 
  gather(`1999`, `2000`, key="Year", value="Cases")

table4b

table4b %>%
  gather(`1999`, `2000`, key="Year", value="Population")

# Spreading ()
# spread() makes long tables shorter and wider (from 1 column to 2)
# use it when an observation is scattered across multiple rows
# each country is spread across two rows:

table2

table2 %>%
  spread(key=type, value = count)

#  separate()
#  pulls apart one column into multiple columns, by splitting wherever a separator character appears

table3

table3 %>%
  separate(rate, into = c("Cases", "Population"), sep = "/")

# Cases and population didnt convert from character to number.

table3 %>% 
  separate(rate, into = c("Cases", "Population"), sep = "/", convert = TRUE)


# unite()
#  is the inverse of separate()
# it combines multiple columns into a single column. 

table5

?unite

table5 %>%
  unite(new,century,year, sep = "_")

table5 %>%
  unite(new, century, year, sep="")

#  Missing Values
# 1.  Explicitly, i.e., flagged with NA. (2015, 4th Quarter)
# 2.  Implicitly, i.e., simply not present in the data (2016, 1st quarter)

stocks <- tibble(
  year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr = c(    1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,  NA, 0.92,  0.17, 2.66)
)

stocks

# 1st way :
#  The way that a dataset is represented can make implicit values explicit.
#  make the implicit missing value explicit by putting years in the columns:

stocks %>% 
  spread(key = year, value = return)


stocks %>% 
  spread(key=year,value=return) %>% 
  gather(`2015`,`2016`, key=year, value=return)

stocks %>% 
  spread(key=year,value=return) %>% 
  gather(`2015`,`2016`, key=year, value=return, na.rm=TRUE)


# 2nd way: 
# Another important tool for making missing values explicit in tidy data is complete():
# It then ensures the original dataset contains all those values,
# filling in explicit NAs where necessary.

?complete

stocks %>% 
  complete(year,qtr)

# 3rd way : fill()
# missing values to be replaced by the most recent nonmissing value

treatment <- tribble(
  ~person,     ~treatment,  ~response,
  "Derreck",     1,          7,
  NA,            2,          10,
  NA,            3,          9,
  "Frost",       1,          4,
  NA,            2,          7
)

treatment

treatment %>% 
  fill(person)

#--------Case study--------

who
view (who)

?who

# Understanding data
# 1. country, year are undertandable.
# 2. iso2, iso3 represnts country code.
# 3. new_sp_m014 : new TB cases with, type of TB, sp=positive pulmonary smear, 
# m=male, 014 = 0-14 years of age.
# new_sp_m014, new_ep_m014, new_ep_f014) these are likely to be values, not variables
# Similarly understand through ?who

# table shows from 1-50 cols, there are total 60 cols, slide it over to get
# 1st and last cols,> new_sp_m014 and newrel_f65
who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key="key", value = "cases", na.rm=TRUE)

who1
view(who1)

who1 %>% 
  count(key)

#  replace the characters “newrel” with “new_rel”.
#  str_replace()

who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key,"newrel", "new_rel"))

who2

# We can separate the values in each code with two passes of separate()


who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep="_")

who3

# There are only new cases of TB so we can drop it.
#  let’s also drop iso2 and iso3 since they’re redundant:

who4 <- who3 %>% 
  select(-new, -iso2, -iso3)

who4

# Next we’ll separate sexage into sex and age by splitting after the  first character:

who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep=1)

who5

# -----complex piping for same case study----

who

who %>% 
  gather(new_sp_m014:newrel_f65, key="code", value ="value", na.rm=TRUE,) %>% 
  mutate(code = stringr::str_replace(code, "newrel", "new_rel")) %>% 
  separate(code, c("new", "type", "sexage"), sep="_") %>% 
  select(-new, -iso2,-iso3) %>% 
  separate(sexage, c("sex", "age"), sep=1)

#------Relational Data with dplyr-----
# The most common place to find relational data is in a relational
# database management system (or RDBMS),  SQL

library(nycflights13)

flights

#  Full carrier name from abbreviation codes
airlines

# information about each airport, identified by the faa airport code:
airports

#planes gives information about each plane, identified by itstailnum:
planes

#  weather gives the weather at each NYC airport for each hour:
weather


# Primary and Foreign Key 
#  A variable can be both a primary key and a foreign key
planes %>% 
  count(tailnum)

planes %>% 
  count(tailnum) %>% 
  filter(n>1)
# they do indeed uniquely identify each observation

flights
view(flights)

airlines 

# Left join
flight2 <- flights %>% 
  left_join(airlines, by="carrier")

view(flight2)


# Inner Join
# matches pairs of observations where their keys are equal. Ignores other.
x<-tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)

x %>% 
  inner_join(y, by="key")

# Left Join
# Gives all left part and matching part of y

x %>% 
  left_join(y,by="key")

# Duplicate Keys
# When you join duplicated keys, you get all possible combinations, the Cartesian product

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  1, "x4"
)

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2"
)

left_join(x,y, by="key")

# Natural Join
# So far we are joining with a single variable by = "key"
# If we keep b= NULL i.e doesnt provide by
# It uses all variables that appear in both tables.
#  For example, the flights and weather tables match on their common variables: 
# year, month, day, hour, and origin:

flights %>% 
  left_join(weather)

#  A named character vector: by = c("a" = "b"). This will match
# variable a in table x to variable b in table y.

flights %>% 
  left_join(airports, c("dest"="faa"))

flights %>% 
  left_join(airports, c("origin"="faa"))

#  ----Strings with stringr------
library(stringr)

string1 <- "This is a string"
string1

string2 <- 'To put a "quote" inside a string, use single quotes'
string2  

double_quote <- "\""
double_quote

double_quote <- '"'
double_quote

single_quote <- "'"
single_quote

# "\u00b5", which is a way of writing non-English characters that
# works on all platforms: Mu (µ)

x<- "\u00b5"
x

# String Length
str_length(c("a", "R for data science", NA))

# Combining Strings
str_c("x","y")
str_c("x","y", sep=",")

str_c("Loki", c(0,1,2,3), "Bhai")

# Combining Strings using [collapse]. 
# Works well when you have concatenated elements.
# Gives a single string
# See diff between sep and collapse

funds <- c("Fund A", "Fund B", "Fund C")
amounts <- c("$10M", "$15M", "$20M")


# Using str_c() with sep
result <- str_c(funds,amounts, sep=" has assets of ")
result

# Each fund's information is stored as separate elements in a vector.
# Collapse is used to combine them into a single string

final_report <- str_c(result, collapse = "|")
final_report


# If :
# Notice how the spaces are created
name <- "Hadley"
time_of_day <- "morning"
birthday <- FALSE

str_c(
  "Good ", time_of_day, " ", name,
  if(birthday) "and Happy Birthday"
)

#  Subsetting Strings,
# str_sub()

x <- c("Apple", "Banana", "Pear")
str_sub(x,1,2)
str_sub(x,-3,-1)

# Locales
#  different languages have different rules for changing case
# Turkish has i's with and without dots
# Locale of turkish is tr

str_to_upper(c("i", "ı"))
str_to_upper(c("i", "ı"), locale = "tr")

# Str_wrap
# break long text into multiple lines at a specified width
text <- "R is a programming language and free software environment for statistical computing and graphics."
wrapped_text <- str_wrap(text, width=30)
wrapped_text
cat(wrapped_text) #Print with Line breaks.


#str_trim
# removes leading and trailing spaces 

text_with_space <- "     Helooooo R World    " 
trimmed_text <- str_trim(text_with_space)
trimmed_text

trimmed_text_left <- str_trim(text_with_space, side="left")
trimmed_text_left

trimmed_text_right <- str_trim(text_with_space, side="right")
trimmed_text_right

#  Basic Matches
x<- c("apple","banana","pear")
str_view(x,"an")
str_view(x,".a.")

#  Anchors
# 1. ^ to match the start of the string.
# 2. $ to match the end of the string.

x<- c("apple","banana","pear")
str_view(x,"^a")
str_view(x,"a$")
str_view(x,"^apple$")

y <- c("grey", "gray", "grape", "mango")
str_view(y, "gr(e|a)y")

# Ending with y or o
str_view(y, "[yo]$")

# Repetition
# how many times a pattern matches
# ? = 0 or 1
# + = 1 or more
# * = 0 or more

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")
str_view(x,"CC+")
str_view(x,"CC*")

# You can also specify the number of matches precisely:
#  • {n}: exactly n
#  • {n,}: n or more
#  • {,m}: at most m
#  • {n,m}: between n and m

str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,3}")

# ----Detect Matches----
# Detect matches for each word if a character vector matches a pattern.
# and Returns answers as true, false for each word.
# when you use a logical vector in a numeric context, FALSE becomes 0 and TRUE becomes 1.

x <- c("apple", "banana", "pear")
str_detect(x, "e")

words
str_detect(words, "^t")

# when you use a logical vector in a numeric context, FALSE becomes 0 and TRUE becomes 1.
sum(str_detect(words, "^t"))

#  # What proportion of common words end with a vowel?
mean(str_detect(words, "[aeiou]$"))

# Find all words containing at least one vowel, and negate
non_vowels_1 <- !str_detect(words, "[aeiou]")
non_vowels_1

#  str_count()
# rather than a simple True or False for each word,
# it tells you how many matches there are in a word:

x <- c("apple", "banana", "pear")
str_count(x,  "a")

# On average, how many vowels per word?
mean(str_count(words, "[aeiou]"))

#  Extract Matches
# To extract the actual text of a match

library(stringr)
sentences

length(sentences)

head(sentences)

colors <- c("red","orange", "yellow", "green", "blue", "purple")

colormatch1<- str_c(colors, collapse = "|")

colormatch1

#  Now we can select the sentences that contain a color, 
# extract the color to figure out which one it is:

has_color <- str_subset(sentences, colormatch1)
has_color

# # extract the color from sentences to figure out which one it is:
matches <- str_extract(has_color, colormatch1)
matches

#  imagine we want to extract nouns from the sentences.
# we’ll look for any word that comes after “a” or “the”

# First understanding "(a|the) ([^ ]+)". It has 2 groups.

#(a|the)
# This captures either "a" or "the" The | (pipe) means "OR".

# ([^ ]+)
# it captures a word that follows "a" or "the".
# [^ ] means "any character except a space" 
# + means "one or more times", so it captures a full word after "a" or "the".

noun <- "(a|the) ([^ ]+)"

has_noun <- sentences %>% 
  str_subset(noun) %>% 
  head(10)

has_noun

str_extract(has_noun, noun)

# Replacing Matches
# str_replace() and str_replace_all() 
# allow you to replace matches with new strings.

x <- c("apple", "pear", "banana")

str_replace(x, "[aeiou]", "-")
str_replace_all(x, "[aeiou]", "-")

# Splitting
# split sentences into words:
sentences %>% 
  head(5) %>% 
  str_split(" ")

# Other Types of Pattern
str_view(fruit, "nana")
str_view(fruit, regex("nana"))

# 1.ignore_case = TRUE
bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, "banana")
str_view(bananas, regex("banana", ignore_case=TRUE))

# 2. multiline = TRUE
# allows ^ and $ to match the start and end of
# each line rather than the start and end of the complete string:
# The [[1]] is used to extract the first (and often only) element from that list.

# see this is a single string.
# # \n represents a newline character in R 
x <- "Line1\nLine2\nLine3"

# Deriving first element
str_extract_all(x, "^Line")[[1]]

# Using multiline=true
str_extract_all(x, regex("^Line", multiline = TRUE))[[1]]


# 3. Comments =TRUE
# allows complex regular expressions more understandable.

# 4.  • dotall = TRUE allows . to match everything, including \n

# 5.  coll() collation rules. 
# doing case-insensitive matching
#  takes a locale parameter (e.g. "tr" is for turkey)


# 6. apropos()
# searches all objects available from the global environment. 
apropos("replace")

# ---Stringi---- (stri_)
# stringi is more comprehensive than strigr (str_)


#------Factors with forcats-----
#  To work with factors, we’ll use the forcats package

# In R, factors are used to work with categorical variables
#  variables that have a fixed and known set of possible values.

# Factors were much easier to work with than characters.
#  many of the functions in base R automatically convert characters to factors.

library(tidyverse)
library(forcats)

x1 <- c('Dec', 'Apr', 'Jan', 'Mar')
x2 <- c('Dec','Apr','Jam', 'Mar')

# factors help to minimize typos and sort accordingly.

month_levels <- c("Jan", "Feb", "Mar", "Apr", "May", "June",
                  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

y1 <- factor(x1, levels = month_levels)
y1

y2 <- factor(x1, levels = unique(x1))
y2

sort(y1) 

# any values not in the set will be silently converted to NA
# Showing our mistake
y3 <- factor(x2, levels = month_levels)
y3

# General SSurvey
gss_cat

?gss_cat

gss_cat %>% 
  count(race)

ggplot(gss_cat, aes(race))+
  geom_bar()


# average number of hours spent watching TV per day across religions:

relig1 <- gss_cat %>% 
  group_by(relig) %>% 
  summarise(
    age=mean(age, na.rm=TRUE),
    tvhours=mean(tvhours, na.rm=TRUE),
    n=n()
  )

relig1

# Understanding "n" more
# n() is a function from dplyr that counts the number of rows in each group.
# Assigning it to n (n=n())creates a new column named n, which stores the count 
# of observations for each religion.

ggplot(relig1, aes(x=tvhours, y=relig))+ geom_point()


# Reordering to get a pattern
?fct_reorder

# Reordering religion according to tv hours.
ggplot(relig1, aes(x=tvhours, y=fct_reorder(relig, tvhours)))+
  geom_point()

ggplot(relig1, aes(x=tvhours, y=fct_reorder(relig, tvhours)))+
  geom_point()+labs(
    title = "Average Tv hours by Religion",
    x = "Average Tv Hours",
    y = "Religion"
  )

# Reordering religion makes it much easier to see that people in the
#“Don’t know” category watch much more TV, and Hinduism and
#other Eastern religions watch much less.

#  plot looking at how average age varies across reported income level.
rincome1 <- gss_cat %>% 
  group_by(rincome) %>%
  summarise(
    age = mean(age, na.rm=TRUE),
    tvhours = mean(tvhours, na.rm=TRUE),
    n=n()
  )
rincome1  

ggplot(rincome1, aes(x=age, y=rincome))+
  geom_point()

# Here factor reordering r-income arbitrarily is not a good idea.
# However we can factor relevel some incomes
# It takes a factor, f, and then any number of levels.

ggplot(rincome1, aes(x=age, y=fct_relevel(rincome, "Not applicable")))+
  geom_point()

# Just for test
ggplot(rincome1, aes(x=age, y=fct_relevel(rincome, "Not applicable", "Lt $1000")))+
  geom_point()


# fct_infreq()
# to order levels in increasing frequency: 

gss_cat %>% 
  mutate(marital=marital) %>% 
  ggplot(aes(marital))+geom_bar()


# fct_infreq is used within the brackets of mutate
# to reorder the factor levels of marital based on their frequency
# It reorders inside the dataset before passing it to ggplot().
gss_cat %>%
  mutate(marital = marital %>% fct_infreq()) %>%
  ggplot(aes(marital)) +
  geom_bar() 


# ---- Modifying Factor Levels-----
#fct_recode(). It allows you to recode, or change, the value of each level.

gss_cat

gss_cat %>% 
  count(partyid)

# The levels are terse and inconsistent. Let’s tweak them to be longer
# and use a parallel construction.

gss_cat %>% 
  mutate(partyidnew = fct_recode(partyid,
    "Republican, Strong" = "Strong republican",
    "Republican, Weak" = "Not str republican",
    "Independent, near rep" = "Ind,near rep",
    "Independent, near dem" = "Ind,near rep",
    "Democrat, weak" = "Not str democrat",
    "Democrat, strong" = "Strong democrat"
  )) %>% 
  count(partyidnew)

#  fct_collapse()  collapse a lot of levels at once unlike fct_recode,
#  For each new variable, you can provide a vector of old levels.

gss_cat %>% 
  mutate(partyidnew2 = fct_collapse(partyid, 
  other = c("No answer","Don't know", "Other party"),
  rep = c("Strong republican", "Not str republican"),
  ind = c("Ind,near rep", "Independent", "Ind,near dem"),
  dem = c("Not str democrat", "Strong democrat")
                                    )) %>% 
  count(partyidnew2)

#  Sometimes you just want to lump together all the small groups to
# make a plot or table simpler. That’s the job of fct_lump():

gss_cat %>% 
  mutate(relig=relig) %>% 
  count(relig)
 
gss_cat %>% 
  mutate(relig = fct_lump(relig)) %>% 
  count(relig)

gss_cat %>% 
  mutate(relig = fct_lump(relig, n =10)) %>% 
  count(relig, sort = TRUE)


# n = Inf tells R to print all rows of the dataframe or tibble
# Normally, when printing a dataframe or tibble in R, it might only show the first few rows,
gss_cat %>% 
  mutate(relig = fct_lump(relig, n =10)) %>% 
  count(relig, sort = TRUE) %>% 
  print(n=Inf)


# ---- Date and Times with Lubridate----
# lubridate is not a part of tidyverse.

library(tidyverse)
library(lubridate)
library(nycflights13)

today()
now()

# Dates from strings -

ymd("2017-01-31")
ymd("2017/01/31")
ymd("2017,01,31")
ymd("2017,Jan,31st")
ymd("2017,January 31")

mdy("January 31st, 2017")

dmy("31 Jan 2017")
dmy("31012017")

ymd_hms("20170131 20:11:59")

mdy_hm("01/31/2027 8:01")

ymd(20170131, tz="UTC")

# All year month day, hours minutes are in a single string in above codes
# Soometimes they can be in diff columns.

flights %>% 
  select(year, month, day, hour, minute)

# use make_date() for dates, or make_datetime() for date-times to create a single string.

example <- make_datetime(2017, 1, 1)
example

example2 <- make_datetime(2017,1,1,8,20)
example2

# doing the same for flights

flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))
     
# See
flights %>% 
  select(year, month, day, hour, minute)    

# The times are represented in a slightly odd format
# use modulus arithmetic (%/%) to pull out the hour components as whole nummbers
# and remainders as minutes. (%/%)
# we will understand function later.


make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
    sched_arr_time = make_datetime_100(year, month, day, sched_arr_time)
  ) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))


flights_dt

# distribution of departure times across the year
flights_dt %>% 
  ggplot(aes(x=dep_time))+
  geom_freqpoly(binwidth=86400)  # 86400 seconds = 1 day

# distribution of departure times  within a single day (for jan 1 2013)
flights_dt %>% 
  filter(dep_time < ymd("2013-01-02")) %>% 
  ggplot(aes(x=dep_time)) +
  geom_freqpoly(binwidth=600) # 600 seconds = 10 minutes

# The reason we use dep_time < ymd("2013-01-02") instead of dep_time == ymd("2013-01-01") is because
# dep_time likely includes both the date and time (e.g., 2013-01-01 08:30:00), not just 2013-01-01
# If you use dep_time == ymd("2013-01-01"), it will only filter rows where dep_time is 
# exactly midnight (00:00:00) on January 1, 2013—which is unlikely to match many records.

# a better approach
flights_dt %>% 
  filter(dep_time >= ymd("2013-01-01") & dep_time < ymd("2013-01-02"))%>% 
  ggplot(aes(x=dep_time)) +
  geom_freqpoly(binwidth=600) # 600 seconds = 10 minutes


#  You may want to switch between a date-time and a date. That’s he
# job of as_datetime() and as_date():

as_datetime(today())
as_date(now())

# “Unix Epoch,” 1970-01-01
# Convert Unix timestamp to a readable date
# If the offset is in seconds, use as_datetime(); if it’s in days, use as_date():

as_datetime(60 * 60 * 10)
as_date(365 * 10 + 2)

# You can pull out individual parts of the date with the accessor functions.
datetime <- ymd_hms("2016-07-08 12:34:56")

year(datetime)
month(datetime)
day(datetime)

mday(datetime)
yday(datetime)
wday(datetime)

month(datetime, label=TRUE)
wday(datetime, label=TRUE, abbr = FALSE)


#  We can use wday() to see that more flights depart during the week
# than on the weekend:

flights_dt %>% 
  mutate(weekday = wday(dep_time, label=TRUE)) %>% 
           ggplot(aes(x=weekday)) + geom_bar()
         
# average delay by minute within the hour (using dep_time)
flights_dt

delay9 <- flights_dt %>% 
  mutate(minute = minute(dep_time)) %>% 
  group_by(minute) %>% 
  summarise(avg_delay=mean(arr_delay, na.rm=TRUE), n =n())
# The n = n() part is calculating the number of flights for each departure minute

ggplot(delay9, aes(minute, avg_delay))+
  geom_line()
#It looks like flights leaving in minutes 20–30 and 50–60 have 
# much lower delays than the rest of the hour!But wait....


# look at the scheduled departure time instead of dep_time.

delay10 <- flights_dt %>% 
  mutate(minute = minute(sched_dep_time)) %>% 
  group_by(minute) %>% 
  summarise(avg_delay = mean(arr_delay, na.rm =TRUE), n=n()) %>% 
  ggplot(aes(minute, avg_delay))+geom_line()

delay10
# so this was a biased data. Thatss why dep_time was giving us a wrong analysis.

# --rounding--
time <- ymd_hms("2024-02-15 14:37:45")

floor_date(time, "minute")
floor_date(time, "hour")
floor_date(time, "week")
floor_date(time, "month")

round_date(time, "hour")

ceiling_date(time, "hour")

flights_dt %>% 
  count(week=floor_date(dep_time, "week")) %>% 
  ggplot(aes(x=week, y=n))+
  geom_line()

#  using each accessor function to set the components of a date/time:
datetime <- ymd_hms('2016-07-08 12:34:56')

year(datetime) <- 2020
datetime

month(datetime) <- 01
datetime

hour(datetime) <- hour(datetime)+1
datetime

# update()
update(datetime, year=2020, month=2, day=2, hour=2)

#If values are too big, they will roll over:
# like lets set day=30 for feb, 
# mday is same as day, just is makes specifically the days for that specific month
# similar for yday.
ymd("2015-02-01") %>% 
  update(mday=30)

# distribution of flights across the course of the day,
# for every day of the year, every 5 minutes
flights_dt

flight101 <- flights_dt %>% 
  mutate(dep_hour = update(dep_time, yday=1)) %>% 
  ggplot(aes(dep_hour))+
  geom_freqpoly(binwidth=300) # 300 seconds = 5 minutes

flight101


# ---Time Stamps--
# ---Arithmetic with dates---
library(lubridate)
library(tidyverse)

# • Durations, which represent an exact number of seconds.
# • Periods, which represent human units like weeks and months.
# • Intervals, which represent a starting and ending point.

# 1. Durations

# Lets create a difference.
h_age <- today() - ymd("2001-03-13")
h_age

# A difftime class object records a time span of seconds, minutes,
# hours, days, or weeks. This ambiguity can make difftimes a little
# painful to work with.

as.duration(h_age)

# Durations come with a bunch of convenient constructors
# converts them to seconds

dseconds(15)
dminutes(10)
dhours(24)
ddays(0.5)
dweeks(3)
dyears(1)

dhours(c(12,24))

# multplication with duration
2*dyears(1)

#addition
dyears(1)+dweeks(12)+dhours(15)

#subtraction
tomorrow <- today()+ddays(1)
tomorrow

last_year <- today()-dyears(1)
last_year

# durations represent an exact number of seconds,
# sometimes you might get an unexpected result due to DST(daylight saving time):

one_pm <- ymd_hms("2016-03-12 13:00:00", tz="America/New_York")
one_pm + ddays(1)
# Here it went one hour extra because of dst, 12 march has only 23 hours.

ymd("2016-01-01")+dyears(1)
# Next year didnt come because its a leap year having one extra day

# 2. Periods 
# Periods are time spans but don’t have a fixed length in seconds;
# instead they work with “human” times, like days and months.

one_pm 
one_pm + days(1)
# Here no extra one hour came.

ymd("2016-01-01")+years(1)
# It ignored one extra day gave answer with human perspective.

# Constructor functions of periods
seconds(15)
minutes(10)
hours(12)
days(7)
months(1)
weeks(7)
years(1)

hours(c(12,24))
months(1:6)

# addition, multiplication, subtraction
10*(months(6)+days(1))
days(50)+hours(25)+minutes(2)

# Flights
flight1 <- flights_dt %>%
  filter(arr_time < dep_time)

flight1
view(flight1)
# some flights appear to arrive at the destination before they departed from origin

# These are overnight flights
# system doesn’t realize it’s an overnight flight and 
# records same date for both departure and arrival:

# e.g. system records
# departure time : march 1st, 11:30 pm
# flight duration 7 hours
# arrival :  march 1st 6:30 am (local time of destination)

# so we bump the arrival date forward by one day to keep the records accurate.

flights_dt_new <- flights_dt %>% 
  mutate(overnight = arr_time < dep_time,
         arr_time= arr_time + days(overnight*1))

flights_dt_new

# Break down of code (Boolean arithmetic)
# 1. overnight = arr_time < dep_time, This creates logical vector (TRUE or FALSE).
# 2. overnight * 1 converts TRUE to 1 and FALSE to 0.
# 3. If overnight is FALSE, it adds 0 days (no change)
# 4. If overnight is TRUE, it adds 1 day.

# Alternative (Conditional Transformation)
flights_dt_new2 <- flights_dt %>% 
  mutate(if_else(arr_time<dep_time, arr_time+days(1), arr_time))

flights_dt_new2

#  Now all of our flights obey the laws of physics:
flights_dt_new %>% 
  filter(arr_time<dep_time)

flights_dt_new2 %>% 
  filter(arr_time<dep_time)

# ---Intervals (%--%) -----
# An interval is a 'duration' with a starting point; that makes it
# precise so you can determine exactly how long it is

years(1)/days(1)

next_year <- today()+years(1)

# lets check duration in an interval
(today() %--% next_year)/ddays(1)

# Lets check the periods in an interval
# we will need to use integer divisiom (o decimals, just whole numbers)
(today() %--% next_year) %/% days(1)

# --Time Zones--

#  current time zone
Sys.timezone()

#  complete list of all time zone names 
length(OlsonNames())
head(OlsonNames())

#  these three objects represent the same instant in time

x1 <- ymd_hms('2015-06-01 12:00:00', tz="America/New_York")
x1

x2 <- ymd_hms('2015-06-01 18:00:00', tz="Europe/Copenhagen")
x2

x3 <- ymd_hms('2015-06-02 04:00:00', tz="Pacific/Auckland")
x3

#  verifying that they’re the same time using subtraction
x1-x2
x1-x3

# Otherwise lubridate always use UTC (Coordinated Universal Time) 
# roughly equivalent to its predecessor GMT (Greenwich Mean Time)


# ---Pipes with magrittr---
# mnemonic = "and then"
# Magrittr is a part of tidyverse.
# however we are focussing on pipe so lets load magrittr

library(magrittr)

# 1. create intermediate objects with meaningful names if pipe steps >10.
# 2. R work best when transforming a single primary object, like a dataframe
# 3. combining two datasets or working with multiple inputs), using pipes may reduce clarity or even break the code.


rnorm(100) %>% 
  matrix(ncol=2) %>% 
  plot()


# supppose we want a string too and we write it later on, it wont work
rnorm(100) %>% 
  matrix(ncol=2) %>% 
  plot() %>% 
  str()

# # “tee” pipe, %T>%
# mnemonic = "side quest" or "tap and continue"
# executes a side effect (printing, saving, plotting) 
## but keeps passing the original data forward.

rnorm(100) %>% 
  matrix(ncol=2) %T>%
  plot() %>% 
  str()

# %$% "Unpack columns"
# Alternative to df$column
# Lets find correlation 
cor(mtcars$disp, mtcars$mpg)

mtcars %$%
  cor(disp,mpg)

# The Assignment Pipe %<>%
mtcars$cyl

mtcars <- mtcars %>% 
  transform(cyl=cyl*2)

mtcars$cyl

mtcars %<>% transform(cyl=cyl*2)
mtcars$cyl



# Ctrl + shift + R

# Header 1 ----------------------------------------------------------------


# --Functions---
#  You should consider writing a function whenever you’ve copied and
# pasted a block of code more than twice.
library(tidyverse)

df <- tibble(
  a=rnorm(10),
  b=rnorm(10),
  c=rnorm(10),
  d=rnorm(10)
)
df

# Rescale a vector to lie between 0 and 1
# Lets move forward to functioon step wise.
df$a <- (df$a - min(df$a, na.rm = TRUE)) /
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))

df$a

# alternative 2
x <- df$a
(x - min(x, na.rm = TRUE)) / 
  (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))

# alternative 3 with range
rng <- range(x, na.rm=TRUE)
rng

x-rng[1]/rng[2]-rng[1]
# Now that we  have simplified the code, and checked that it still works, 
# We can turn it into a function:  

# First we will create a function and then we will put the data in it.
# Step 1 : name a function, here it is rescale101
# Step 2: function has inputs/arguments, Here its capital X, 
# -------: IF we had more the call would look like function(X,Y,Z)
# Step 3 : body of the function, { }.

rescale101 <- function(X){      # Capital X
  rng <- range(X, na.rm=TRUE)   # Capital X
  (X-rng[1])/(rng[2]-rng[1])
} 

# Test1
rescale101(c(0,5,10))

# Test2
rescale101(c(77,76.56,9,10,0))

# Putting our created dataframe now in functionn
df$a <- rescale101(df$a)
df$b <- rescale101(df$b)
df$c <- rescale101(df$c)
df$d <- rescale101(df$d)

df$a
df$b
df$c
df$d

# Conditional Execution -------------
if (condition) {
  # code executed when condition is TRUE
} else {
  # code executed when condition is FALSE
}

# Let's try an example with if using below function:
# This function is useful when working with named vectors or lists 
# where checking for missing or empty names is necessary.

?names
?length


has_name <- function(x) {
  nms <- names(x)  # Get names of the object (vector or list)
  
  if (is.null(nms)) {        
    return(rep(FALSE, length(x)))  # If names are NULL, return all FALSE, else true
  } else {
    return(!is.na(nms) & nms != "")  # Check for NA and empty strings
  }
}

# Testing  1
x <- c(a=1, b=2, 3, c=4)
print(has_name(x))

# Test 2
x<- c(NA, 1, a=2)
print(has_name(x))


# Nested Ifs
# They may be complex
# Use switch() and cut()

# Confidence Interval around mean
# Mean of whole data may be different from means of different samples from data
# Confdence Interval is a 'range' derived from means of different samples
# Where true value mean has high probability to exist.
# probaibilty of CI remains between 95% to 99% to find that range CI Range.

# Formula (std normal distribution, mean=0, sd=1)
# CI (lower value of range) = x bar - Z. (s/sqrt(n))
# CI (upper value of range) = x bar + z. (s/sqrt(n))
# xbar: mean
# z: zvalue of CI
# s: standard deviation
# n = sample size

# Z value
# CI of 95% has a z value of 1.96

# alpha 
# "leftover probability" that is not included in the confidence interval (CI).
# If We are calculating CI at 95%, alpah = 0.5%
# Since the normal distribution is symmetric, we split the 5% equally into both tails
# 2.5% (0.025) is in the left tail.
# 2.5% (0.025) is in the right tail.



#    (Left tail)        (Middle 95%)       (Right tail)
#    ⬇                    ⬇                    ⬇
#     |--------|---------------------------------|--------|
#    -∞      -1.96              0              1.96     +∞



# left tail cutoff at 0.25%
# right tail = left + CI = 0.25 + 0.95 = 0.975

# qnorm = it calculates z score
# here calculating z score for 95% CI
# Begins from 0.25 probaility: qnorm(0.25) = 1.96
# This means 2.5% of values are smaller than -1.96 standard deviations from the mean.
# Ends at 0.975 probability : qnorm(0.975) =1.96
# This means 97.5% of values are smaller than +1.96 standard deviations from the mean



mean_ci <- function(x, conf=0.95) {    # Defaulting Conf at 0.95
  se <- sd(x)/sqrt(length(x))           # (s/sqrt(n))
  alpha <- 1-conf
  mean(x)+ se*qnorm(c(alpha/2, 1-alpha/2))  # deriving z for both lower and upper value, 0.025 and 0.975
}


x<-runif(100)
x

mean_ci(x) 
mean_ci(x, conf=0.99) # function allows to change values

# Explicit Return Statements
# The value returned by the function is usually the last statement it
# evaluates, but you can choose to return early by using return()


# Vectors -----------------------------------------------------------------
library(tidyverse)

typeof(letters)
typeof(1:10)

# Atomic Vectors
#  logical, integer, double, character, complex, and raw

# Logical Vector
1:10 %% 3 ==0

# Numeric
typeof(1)    #  Doubles are approximations, represent floating point numbers
typeof(1L)

x<-sqrt(2)^2
x  

x==2
# Here the result is not true

near(x,2)
# This gives true

# Integers have one special value
# NA

# Doubles have four types of Na values
# NA, -Inf, inf, Nan
c(-1,0,1)/0

# Character Vector
# Each element of character vector is a string.

#  Coercion
# Conversion of one type to another

# Explicit Coercion
x<-1
typeof(x)

as.character(x)


# Implict Coercion
x <- sample(20,100, replace=TRUE)
y <- x>10

sum(y)
# 49 numbers are greater than 10, It converted logical vector to numeric.

# Naming Vectors
c(x=1,y=2,z=3)

# Subsetting
# Just like filter() is used in a tibble.
# [] and [[]] are subsetting functions for vectors.

x <- c("apple", "mango", "banana", "papaya", "pomegranate", "grapes")

# Numbers define the position of elements
x[3]
x[c(3,2,5)]
x[c(1,1,5,5,5,2)]

# Negative numbers drop that element and returns the remaining
x[-6]
x[c(-1,-6)]

# Its an error to mix positive and negative values
x[1,-1]
x[0]

# All non-missing values of x
x <- c(10,3,NA, 5,8,1,NA)
x[is.na(x)]

# Odd/even
x[x%%2==0]

# If you have a named vector, you can subset it with a character vector
x<- c(abc=1, def=2, xyz=5)
x[c("abc","xyz")]

# Matrix
x <- matrix(1:8, 4,4)

# First Row
x[1,]

# first column
x[,1]

# 1st row and second column
x[1,2]

# all rows except first
x[-1,]

# all rows and columns exept 1st 
x[-1,-1]

# -- Lists  (Recursive Vectors)---
# Lists can contain two types of vectors
# 1 List can contain 2  other lists

x <- list(1,2,3)
x

str(x) #structure

y <- list(a=1,b=2,c=3)
str(y)

y <- list('a', 1L, 1.5, TRUE)
str(y)

z <- list(list(1,2), list(3,4))
str(z)

# Subsetting List
abcd <- list(a=1:3, b="a string", c=pi, d=list(-1,-5))

abcd[1]
abcd[c(1,2)]
abcd[1:2]

str(abcd[4])
str(abcd[1:2])

# extracts a single componenet of a list

# Positioning only
str(abcd[[1]][[1]])
str(abcd[[4]][[2]])

# Naming and positioning
str(abcd$a[1])
str(abcd$a[2])
str(abcd$d[2])

# --- Attributes---
# named list of vectors that can be attached to any object
?attr

x <- 1:5
attr(x, "message") # Currently its is not set so it will show null

attr(x, "message") <- "Hello this is a cudtome attribute"
attr(x,"note") <- "This vector contains numbers from 1 to 5"

attr(x, 'message')
attr(x,"note")
attributes(x)

# Augmented Vectors
# Atomic vectors and lists are the building blocks for other important vector 
# Factors, Date-Time, Tibbles

# Factors
# designed to represent categorical data
x <- factor(c("ab", "cd", "ab"), levels=c("ab", "cd", "ef"))
typeof(x)
attributes(x)

# Dates and Date-Times
x <- as.Date("1971-01-01")
unclass(x)
typeof(x)
attributes(x)

# tibbles
tb <- tibble::tibble(x=1:5, y=5:1)
typeof(tb)
attributes(tb)


# Iteration with Purr -----------------------------------------------------
library(tidyverse)

# first we will use itiration from base R and then from Purr.

# For Loops--
df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)
# we can find median for all by this
median(df$a)
median(df$b)
median(df$c)
median(df$d)

# But this can be done by iteration for all in one go.
# Lets go step by step

# This gives us an empty numeric(double) vector
vector("double")

# this gives empty numeric vector with column length as in df
vector('double', ncol(df))

# So we are trying to bring an output which is numeric and have some defined length.
# This is very important for efficiency.

# Main Code (basic theme of for loop)
output <- vector("double", ncol(df)) # 1. Output, Runit first

for (i in seq_along(df)) {           # 2. sequence
  output[i] <- median(df[[i]])       # 3. body, run them after above 
}

output

# For Loops Variation----------
# 1. Modifying an existing object, instead of creating a new object.
# 2. Looping over names or values, instead of indices.
# 3. Handling outputs of unknown length.
# 4. Handling sequences of unknown length.

# The Map Functions---
# 1. map() makes a list.
# 2. map_lgl() makes a logical vector.
# 3. map_int() makes an integer vector.
# 4. map_dbl() makes a double vector.
# 5. map_chr() makes a character vector.

#  Compared to using a for loop, focus is on the operation being per
# formed (i.e., mean(), median(), sd()), not the bookkeeping required
# to loop over every element and store the output.


map_dbl(df, mean)
map_dbl(df, median)
map_dbl(df, sd)

# Using pipes
df %>% map_dbl(mean)
df %>%  map_dbl(median)
df %>% map_dbl(sd)

# Shortcuts (.f)
# The split(.$cyl) function creates a list of data frames,
# where each subset contains only cars with the same number of cylinders.

mtcars

models <- mtcars %>% 
  split(.$cyl)

models


# fit a linear model to each group in a dataset. 
# map() applies the function to each subset
# function(df) lm(mpg ~ wt, data = df) runs a linear regression for each subset
# The df inside the map() function represents each subset of the mtcars

models2 <- mtcars %>% 
  split(.$cyl) %>% 
  map(function(df) lm(mpg ~ wt, data=df))

models2  

#---Mapping over Multiple Arguments---
# rnorm(n, mean = 0, sd = 1) syntax of rnorm()

# This gives us 5 numbers from normal distribution having mean 0 and sd=1
rnorm(n=5)

# This gives us 5 numbers from normal distribution having mean =5
rnorm(n=5, mean=5)

# Lets  use map it gives us random numbers for 3 diff means
mu <- list(5,10,-3)

mu %>% 
  map(rnorm,n=5)

# What if you also want to vary the standard deviation along with mean.

sdeviations <- list(1,5,10)

seq_along(mu) %>% 
  map(~rnorm(5, mu[[.]], sdeviations[[.]]))

# Alternative
map2(mu, sdeviations, rnorm, n=5)

# You could also imagine map3(), map4(), map5(), map6(), etc., but
# that would get tedious quickly. Instead, purrr provides pmap()
n<- list(1,3,5)

args1 <- list(n,mu,sdeviations)

args1 %>% 
  pmap(rnorm)

# positional matching 
args2 <- list(mean=mu, sd=sdeviations, n=n)  

args2 %>% 
  pmap(rnorm)

# Alternative
params <- tribble(
  ~mean, ~sd, ~n,
  5,       1,  1,
  10,      5,  3,
  -3,      10,  5
)

params %>% 
  pmap(rnorm)

# ---- walk---
#  Walk is an alternative to map that you use when you want to call a
# function for its side effects, rather than for its return value.

x <- list(1, "a", 3)
x %>% 
  walk(print)

# Let's understand map again here.
# Letss split mt cars and apply ggplot to each subset

library(ggplot2)

plots <- mtcars %>% 
  split(.$cyl) %>% 
  map(~ggplot(.,aes(mpg,wt))+geom_point())

# map() iterates over each dataframe created by split()
# The ~ (tilde) creates an anonymous function where

# . refers to the current dataframe being processed
# It applies ggplot(., aes(mpg, wt)) + geom_point() to each subset.

paths <- stringr::str_c(names(plots), ".pdf")

# The paths variable is creating a vector of file names for saving the plots.

# names(plots): Extracts the names of the list elements in plots. 
# Since plots was created using split(.$cyl), the names correspond to 
#the unique values of cyl (e.g., "4", "6", "8" for cylinder counts in mtcars).

# stringr::str_c(names(plots), ".pdf"): Concatenates each name with the ".pdf" 
# extension to form file names like "4.pdf", "6.pdf", and "8.pdf".


pwalk(list(paths, plots), ggsave, path = tempdir())


#-- Predicate Functions--
iris
str(iris)

# Keeps only factor columns
iris %>% 
  keep(is.factor) %>% 
  str()

# Removes factor columns
iris %>% 
  discard(is.factor) %>% 
  str()

#  some() and every() determine if the predicate is true for any or for
# all of the elements:

x <- list(1:5, letters, list(10))

x %>% 
  some(is_character)

x %>% 
  every(is_vector)

# detect() finds the first element where the predicate is true;
# detect_index() returns its position:

x <- sample(10)
x

x %>% 
  detect(function(num) num>5)

# or
x %>% 
  detect(~.>5)

x %>% 
  detect_index(~.>5)


# Model -------------------------------------------------------------------

library(tidyverse)
library(modelr)

#What Does na.action = na.warn Do?
# It removes missing values (NA) from data when functions like lm() or model.frame() are used.
# It displays a warning when missing values are removed.

options(na.action = na.warn)


# Begin 
sim1

ggplot(sim1, aes(x,y))+geom_point()
# The graph is linear (y=ax+b)

# lets generate some models having linear relationship and verlay them on sim1
# Using geom_abline, it takes a slope and intercept as parameters.

models <- tibble(
  a = runif(250, -5, 5),
  b = runif(250, -20, 40)
)

ggplot(sim1, aes(x,y))+
  geom_abline(aes(intercept = b, slope=a), data=models, alpha=1/4)+
  geom_point()

# We have generated 250 models overlaying sim1 
# We need to find good models, a good model is close to the data
#  One easy place to start is to find the vertical distance between each point and the model, 

# distance is just the difference between the y value given by the
# model (the prediction), and the actual y value in the data (the response).


# First Turning our model into an R function
# # Creating a linear model function in R (y=ax+b or y=a1.x + a2)
# a and data are function arguments (or parameters) in the below code

model1 <- function(a, data){
  a[1] * data$x + a[2]
}

# Testing the function
# a[1] = 1.5 (slope)
# a[2] = 7 (Intercept)
# data =sim1
model1(c(1.5,7), sim1)

# Now we have to calculate distances of models for 30 plots.
# We will Use root mean squared deviation.

measure_distance <- function(mod, data){
  diff <- data$y - model1(mod,data)
  sqrt(mean(diff ^ 2))
}

# 1. mod: A numeric vector (likely containing two values, representing the
# intercept and slope, similar to a in model1).
# 2. data: A dataset (expected to have columns x and y).
# 3. model1(mod, data) computes the predicted y values using the model1 function.

# Testing function
measure_distance(c(1.5,7), sim1)

#  Now we can use purrr to compute the distance for all the models defined previously. 

# First simplify our code of testing
sim1_dist <- function(a,b){
  measure_distance(c(a,b), sim1)
}

# Test
sim1_dist(1.5,7)
# This gives same as above previous test, measure_distance(c(1.5,7), sim1)

# Now we have models tibble and function to calculate RMSE
# We will mutate model tibble and will bring calculated distances
models

models <- models %>% 
  mutate(dist = map2_dbl(a,b, sim1_dist))

models

# Next, let’s overlay the 10 best models on to the data.
# color them by reducing distances (-dist)
# Filter out distances for best 10
ggplot(sim1, aes(x,y))+
  geom_point(size=2, color="grey30")+
  geom_abline(
    aes(slope=a, intercept=b, color=-dist),
    data=filter(models, rank(dist)<=10)
  )

#  10 Best models this time drawing red circles underneath them:
ggplot(models, aes(a,b))+
  geom_point(
    data=filter(models, rank(dist)<=10),
    size=4, color="red"
  )+
  geom_point(aes(color=-dist))

#  generate an evenly spaced grid of points
# Rougly picking upthe parameters of grid.

# expand.grid(a1, a2)
# This creates all possible combinations of a and b

grid <- expand.grid(
  a=seq(1,3, length=25),
  b=seq(-5,20, length=25)
) %>% 
  mutate(dist=map2_dbl(a,b, sim1_dist))

grid %>% 
  ggplot(aes(a,b))+
  geom_point(
    data=filter(grid,rank(dist)<=10),
    size=4, color="red"
  ) +
  geom_point(aes(color=-dist))

# When you overlay the best 10 models back on the original data, they
# all look pretty good:

ggplot(sim1, aes(x, y)) +
  geom_point(size = 2, color = "grey30") +
  geom_abline(
    aes(intercept = b, slope = a, color = -dist),
    data = filter(grid, rank(dist) <= 10)
  )

# You could imagine iteratively making the grid finer and finer until
# you narrowed in on the best model.

# But there’s a better way to tackle that problem: 
# a numerical minimization tool called Newton–Raphson search. 
# In R, we can do that with optim():

?optim
# General-purpose optimization
# meaning it finds the values of parameters 
# that minimize or maximize a given function.

best_line <- optim(par=c(0,0), fn=measure_distance, data=sim1)
best_line
best_line$par
# par = c(0, 0) → Initial guess for the parameters (a1 and a2).
# fn = measure_distance → The function to be minimized (in this case, RMSE)
# data = sim1 → Additional argument passed to measure_distance()
# best$par extracts the optimal values of a1 and a2 (intercept and slope).

ggplot(sim1, aes(x,y))+
  geom_point()+
  geom_abline(slope = best_line$par[1], intercept = best_line$par[2])


# A linear model has the general form 
# y = a_1 + a_2 * x_1 + a_3 * x_2 + ... + a_n * x_(n - 1). 

# R has a tool specifically designed for fitting linear models called lm()
# Formulas look like y ~ x, which lm() will translate to a function like y = a_1 + a_2 * x.

sim1_mod <- lm(y~x, data=sim1)
coef(sim1_mod)
# The result is same as givem by optim()


#----Visualizing Models----

# Predictions
#  we start by generating an evenly spaced grid of values that covers the region where our data lies. 
# grid here generates a new data frame with all unique values of x 
#  from sim1 while keeping other variables constant

grid <- sim1 %>% 
  data_grid(x)

grid

grid <- grid %>% 
  add_predictions(sim1_mod)

grid

ggplot(sim1)+
  geom_point(mapping = aes(x=x,y=y))+
  geom_line(data=grid, mapping = aes(x=x,y=pred), color="red")

# The residuals are just the distances between
#  the observed and predicted values that we computed earlier.
# The predictions tell you the pattern that the model has captured
# residuals tell you what the model has missed.

sim1_res <- sim1 %>% 
  add_residuals(sim1_mod)

sim1_res


ggplot(sim1_res, aes(resid))+
  geom_freqpoly(binwidth=0.5)

# average of the residual will always be 0.
# Tall bars/peaks near 0 → Most predictions are close to actual values (good model).
# Good model: Most residuals cluster around 0, forming a bell shape (normal distribution).
# Bad model: Residuals spread out widely or show a trend, meaning the model is missing something.

# ---- Formulas ~ Model Families---

#  model_matrix() function
#  It takes a data frame and a formula and returns a tibble that defines
# the model equation:


# 

df <- tribble(
  ~y, ~x1, ~x2,
  4,   2,   5,
  5,   1,   6
)

# "Build a model matrix using only x1, ignoring x2
model_matrix(df, y~x1)

# How the model_matrix works
# 1. The formula y~x1 means : y=B0+B1x1
# 2. model_matrix() adds an intercept column of 1s, so our transformed matrix
# [1, 2]
# [1, 2]
# 3. First column represent B0 (intercept), by default 1s
# 4. second column is x1 (slope), as given by df

# 5. Matrix equation:
#  [ y1 ]   [ 1  x1_1 ]   [ β0 ]  
#  [ y2 ] = [ 1  x1_2 ] * [ β1 ] 

# Now we have the equation, it makes easy to apply linear algebra for estimating
# B0 and B1 using matrix operation
# A standard input for regression models like lm().

# We can drop the default 1s created for intercept.
model_matrix(df, y~x1-1)

# Adding more variables here x2
model_matrix(df, y~x1+x2)


# Categorical Variables-----
# Generating a function from a formula is straightforward when the
#predictor is continuous. But for categorical variable, its complicated.

df <- tribble(
  ~sex, ~response,
  "male",    1,
  "female",  2,
  "male",   3
)

model_matrix(df, response~sex)
#  It created a column that is perfectly predicta ble based on the other columns
# (i.e., sexfemale = 1 - sexmale)


#sim2, # We can fit a model to it and generate predictions.
sim2

ggplot(sim2)+
  geom_point(aes(x,y))

# eequation
mod2 <- lm(y~x, data=sim2)
mod2

# Grid and predictions from equation
grid <- sim2 %>% 
  data_grid(x) %>% 
  add_predictions(mod2)

grid

# Plotting the predictions
ggplot(sim2, aes(x=x))+
  geom_point(aes(y=y))+
  geom_point(data=grid, aes(y=pred), color="red", size=4)

# Interactions (Continuous and Caategorical Variable)
# What happens when we combine a continuous and a categorical variable.
sim3

ggplot(sim3, aes(x=x1, y=y))+
  geom_point(aes(color=x2))

# There are two possible models you could fit to this data:
mod1 <- lm(y ~ x1 + x2, data = sim3)
mod2 <- lm(y ~ x1 * x2, data = sim3)

# Data grid
# To generate predictions from both models simultaneously, we
# can use gather_predictions(),
grid <- sim3 %>% 
  data_grid(x1,x2) %>% 
  gather_predictions(mod1, mod2)

grid

# We can visualize the results for both models on one plot using faceting:

ggplot(sim3, aes(x=x1, y=y, color=x2))+
  geom_point()+
  geom_line(data=grid, aes(y=pred))+
  facet_wrap(~model)
  
#  We can take look at the residuals.
sim3 <- sim3 %>% 
  gather_residuals(mod1, mod2)

ggplot(sim3, aes(x1, resid, color = x2)) +
  geom_point() +
  facet_grid(model ~ x2)

# Interactions(Two Continuous)
sim4

mod1 <- lm(y~x1+x2, data=sim4)
mod2 <- lm(y~x1*x2, data=sim4)

grid <- sim4 %>% 
  data_grid(
    x1=seq_range(x1,5),
    x2=seq_range(x2,5)
  ) %>% 
  gather_predictions(mod1, mod2)

grid

ggplot(grid, aes(x1,x2))+
  geom_tile(aes(fill=pred))+
  facet_wrap(~model)


# More about seq_range
seq_range(c(0.123, 0.923423), n=5)
seq_range(c(0.123, 0.923423), n=5, pretty=TRUE)
seq_range(c(0.123, 0.923423), n=5, trim=0.50)
seq_range(c(0.123, 0.923423), n=5, expand = 0.50)


# Transformations
# we can also perform transformations inside the model formula
# Transformations are useful because you can use them to approximate nonlinear functions.

# y = a1 + a2x1 + a3x2
# log(y) = a1 + a2 * sqrt(x1) + a3 * x2 

# Now we will set the code for log y equation
# log(y) ~ sqrt(x1) + x2

#  If your transformation involves +, *, ^, or -, you’ll need to wrap it in I() 
# so R doesn’t treat it like part of the model specification.
#  y ~ x + I(x ^ 2) is translated to y = a_1 + a_2 * x + a_3 * x^2

#  If you forget the I() and specify y ~ x ^ 2 + x, 
# R will compute y ~ x * x + x. x * x

df <- tribble(
  ~y, ~x,
  1,   1,
  2,   2,
  3,   3
)

# Wrong for our eq.
model_matrix(df, y~x^2+x)

# Correct for our eq
model_matrix(df, y~I(x^2)+x)

# Alternative 1
# a polynomial regression model where x is raised to powers up to 2 
# i.e, y = a0 + a1.x1 +a2.x^2
model_matrix(df, y~poly(x,2))

# using poly(): outside the range of the data, polynomials rapidly shoot off 
#to positive or negative infinity.

# Alternative 2
# natural spline, splines::ns():
library(splines)
model_matrix(df, y ~ ns(x,2))


# --- approximating a nonlinear function:--

# Why added randomness (rnorm(length(x)))
# In real-world data, things are never perfectly predictable
# there’s always some variation. The random noise simulates this uncertainty.



sim5 <- tibble(
  x= seq(0, 3.5*pi, length=50),
  y= 4*sin(x) + rnorm(length(x))
)

sim5

ggplot(sim5, aes(x,y))+
  geom_point()


# Fitting five models to this data.
mod1 <- lm(y ~ ns(x, 1), data = sim5)
mod2 <- lm(y ~ ns(x, 2), data = sim5)
mod3 <- lm(y ~ ns(x, 3), data = sim5)
mod4 <- lm(y ~ ns(x, 4), data = sim5)
mod5 <- lm(y ~ ns(x, 5), data = sim5)

# .pred ="y" used to rename the default pred  to y
grid <- sim5 %>% 
  data_grid(x=seq_range(x,n=50, expand=0.1)) %>% 
  gather_predictions(mod1, mod2, mod3, mod4, mod5, .pred="y")

grid

ggplot(sim5, aes(x,y))+
  geom_point()+
  geom_line(data=grid, color="red")+
  facet_wrap(~model)

# Missing Values
#  modeling functions will drop any rows that contain missing values silently.
# To make sure we get a warning: options(na.action = na.warn)

#--- Other Model Families--
# 1. Generalized linear models, e.g., stats::glm()
# 2.  Generalized additive models, e.g., mgcv::gam()
# 3.  Penalized linear models, e.g., glmnet::glmnet()
# 4. Robust linear models, e.g., MASS:rlm()
# 5.  Trees, e.g., rpart::rpart()


# Model Building ----------------------------------------------------------

library(tidyverse)
library(modelr)
options(na.action=na.warn)

library(nycflights13)
library(lubridate)
library(ggplot2)

install.packages("gridExtra")
library(gridExtra)

# Why Are Low-Quality Diamonds More Expensive?
p1 <- ggplot(diamonds, aes(cut, price))+geom_boxplot()
p2 <- ggplot(diamonds, aes(color, price))+geom_boxplot()
p3 <- ggplot(diamonds, aes(clarity, price))+geom_boxplot()

grid.arrange(p1,p2,p3)

# Acc to diamond grading standards
# worst color = J (yellow tint)
# Best colorless = D
# worst clarity (internal flaws / inclusions) = I1
# Flawless in clarity = IF (Internally Flawless)

# It looks like lower quality diamonds have higher prices.
# But weight(carat) is the single most important factor in determining price.

ggplot(diamonds, aes(carat, price))+geom_hex(bins=50)


# let’s make a couple of tweaks to the diamonds dataset to make it easier to work with:
# 1.  Focus on diamonds smaller than 2.5 carats (99.7% of the data).
# 2.  Log-transform the carat and price variables (makesthe pattern linear)

diamonds2 <- diamonds %>% 
  filter(carat<=2.5) %>% 
  mutate(lprice=log2(price), lcarat=log2(carat))

ggplot(diamonds2, aes(lcarat, lprice))+
  geom_hex(bins=50)

# Fitting aa model
mod_diamonds <- lm(lprice~lcarat, data=diamonds2)


# create a grid
# Instead of using the raw, scattered dataset, we create a grid of evenly spaced values
# A smooth curve when plotting predictions.
# We cover the full range of possible values, even if our data has gaps.

# Working of grid:
# Generates 20 evenly spaced values for carat, covering the min to max range.
# add new column, Converts carat to log2 scale 
# add_pred: uses mod_diamond (a trained model) to predict lprice (log2 of price).
# Converts predicted log2(price) back to actual price by exponentiating.


grid <- diamonds2 %>% 
  data_grid(carat=seq_range(x=carat, n=20)) %>% 
  mutate(lcarat=log2(carat)) %>% 
  add_predictions(mod_diamonds, "lprice") %>% 
  mutate(price=2^lprice)

grid

# overlay the predictions on the raw data
ggplot(diamonds2, aes(carat, price))+
  geom_hex(bins=50)+
  geom_line(data=grid, color="red", size=1)

# If we believe our model
# Then large diamonds are much cheaper than expected.
# This is probably because no diamond in this dataset costs more than $19,000.


#  Now we can look at the residuals
diamonds2 <- diamonds2 %>% 
  add_residuals(mod_diamonds, "lresid")

ggplot(diamonds2, aes(lcarat, lresid))+
  geom_hex(bins=50)
#If the residuals are randomly scattered, it means the model has
# captured the main patterns and removed any strong trends
# Residuals verifies that we have successfully removed the strong linear pattern.

r1 <- ggplot(diamonds2, aes(cut, lresid))+geom_boxplot()
r2 <- ggplot(diamonds2, aes(color, lresid))+geom_boxplot()
r3 <- ggplot(diamonds2, aes(clarity, lresid))+geom_boxplot()

grid.arrange(r1,r2,r3)

# Now we see the relationship we expect: as the quality of the diamond
# increases, so to does its relative price.

# A residual of -1 means that the actual lprice is 1 unit lower than the predicted lprice

# ----- A More Complicated Model----
mod_diamond2 <- lm(lprice~lcarat + color + cut + clarity, data=diamonds2)

# data_grid(cut, .model = mod_diamond2) creates a grid where:
# cut takes all unique values from the dataset

# Other variables (lcarat, color, clarity) are filled in automatically based on their "typical" values.
#  For continuous variables, it uses the median, and for categorical
# variables, it uses the most common value (or values, if there’s a tie):

grid <- diamonds2 %>% 
  data_grid(cut, .model = mod_diamond2) %>% 
  add_predictions(mod_diamond2)

grid

ggplot(grid, aes(cut, pred)) +
  geom_point()


diamonds2 <- diamonds2 %>%
  add_residuals(mod_diamond2, "lresid2")

ggplot(diamonds2, aes(lcarat, lresid2)) +
  geom_hex(bins = 50)


#  What Affects the Number of Daily Flights----

#  Let’s get started by counting the number of flights per day 
# and visualizing it with ggplot2.
  daily <- flights %>% 
  mutate(date=make_date(year, month, day)) %>% 
  group_by(date) %>% 
  summarise(n=n())

daily

ggplot(daily, aes(date, n))+geom_line()


# Day of Week
# there’s a very strong day-of-week effect that dominates the subtler patterns
daily <- daily %>% 
  mutate(wday = wday(date, label=TRUE))

ggplot(daily, aes(wday, n))+geom_boxplot()
# There are fewer flights on weekends because most travel is for business.

# One way to remove this strong pattern is to use a model.
mod <- lm(n~wday, data=daily)

grid <- daily %>% 
  data_grid(wday) %>% 
  add_predictions(mod, "n")

grid

ggplot(daily, aes(wday,n))+
  geom_boxplot()+
  geom_point(data=grid, color='red', size=4)

# Next we compute and visualize the residuals:


daily <- daily %>% 
  add_residuals(mod)

ggplot(daily, aes(date, resid))+
  geom_ref_line(h = 0, colour="red")+
  geom_line()

?geom_ref_line
# 1. It adds a horizontal reference line at y = 0 on your plot.
# 2. The red line at y = 0 helps check if residuals are 
# randomly scattered (a sign of a good model).
# 3. If residuals are randomly spread above & below 0, the model is working well.
# 4. If there's a pattern (like a curve or clustering), the model might be missing something.


# Drawing a plot with one line for each day of the week 
ggplot(daily, aes(date, resid, colour = wday))+
  geom_ref_line(h=0, colour = "red")+
  geom_line()

# Changing palettes and size of lines to have good visuals (S is capital of set1)
ggplot(daily, aes(date, resid, colour = wday))+
  geom_ref_line(h=0, colour = "red")+
  geom_line(size=0.8)+
  scale_color_brewer(palette = "Set1")

# Our model seems to fail starting in June
# 1. We see a regular pattern. Less flights on weekened
# 2. There are some days with far fewer flights than expected.
# 3. Our model fails to accurately predict the number of flights on
# Saturday: during summer there are more flights than we expect,
# and during fall there are fewer

# Residual= Actual No of flights  − Predicted No of flights
# a negative residual (resid <= -100) means that the actual 
#flight number was much lower than predicted by model.
daily %>% 
  filter(resid <= -100)
# These are mostly american public holidays


# There seems to be some smoother long-term trend over the course of a year too

# geom_smooth() is used to identify trends and patterns in data 
# that might not be obvious from raw points or lines.
# 1. If residuals have an overall increasing/decreasing trend
# 2. If there are seasonal patterns in flight delays
# 3.  If the model systematically over/underpredicts delays over time

# se = FALSE,  removes the shaded confidence interval
# span = 0.20 controls how much the curve follows the data
# 1. Smaller span (e.g., 0.20) → More responsive to short-term fluctuations.
# 2. Larger span (e.g., 0.80) → Smoother, more general trend

daily %>% 
  ggplot(aes(date, resid))+
  geom_ref_line(h=0, colour="red")+
  geom_line(color="grey50")+
  geom_smooth(se=FALSE, span=0.20)
# There are fewer flights in January (and December), 
# and more in summer (May–Sep)

# ---Seasonal-Saturday Effect---

# Let’s first tackle our failure to accurately predict the number of
# flights on Saturday.
daily %>% 
  filter(wday=="Sat") %>% 
  ggplot(aes(date,n))+
  geom_point()+
  geom_line()+
  scale_x_date(
    NULL,                            # No axis title
    date_breaks = "1 month",         # Show a tick mark every 1 month
    date_labels = "%b"               # Format labels as abbreviated month names
  )

# date labels
# %m = 1,2,3...
# %b = Jan, Feb March ...
# %B = January, February, March ...

# why Saturday have higher travel:
#  I suspect this pattern is caused by summer holidays: many people go
# on holiday in the summer, and people don’t mind travelling on Saturdays 
# for vacation. Looking at this plot.


# Let’s create a “term” variable that roughly captures the three school
# terms (spring, summer, fall), and check our work with a plot:
# 1. Spring : Jan to June
# 2. summer : June to end aug
# 3. winter fall : End aug to Jan
?cut

term <- function(date){
  cut(date,
      breaks = ymd(20130101, 20130605, 20130825, 20140101),
      labels = c("spring", "summer", "fall")
      )
}

# testing function
term(daily$date)

daily <- daily %>%
  mutate(term = term(date))

daily %>% 
  filter(wday=="Sat") %>% 
  ggplot(aes(date, n, color=term))+
  geom_point(alpha=1/3)+
  geom_line()+
  scale_x_date(
    NULL,
    date_breaks = "1 month",
    date_labels = "%b"
  )


#  It’s useful to see how this new variable affects the other days of the week:  
daily %>% 
  ggplot(aes(wday,n, color=term))+
  geom_boxplot()

# Coming back for model.
# It looks like there is significant variation across the terms, so fitting a
#separate day-of-week effect for each term is reasonable. 

mod1 <- lm(n~wday, data=daily)
mod2 <- lm(n~wday*term, data=daily)

daily %>% 
  gather_residuals(without_term=mod1, with_term=mod2) %>% 
  ggplot(aes(date, resid, color=model))+
  geom_line(alpha=0.75)
# This improves our model, but not as much as we might hope.

# We can see the problem by overlaying the predictions from the
# model onto the raw data
grid <- daily %>% 
  data_grid(wday, term) %>% 
  add_predictions(mod2, "n")

ggplot(daily, aes(wday, n)) +
  geom_boxplot() +
  geom_point(data = grid, color = "red") +
  facet_wrap(~ term)

#  Our model is finding the mean effect, but we have a lot of big outliers, 
# so the mean tends to be far away from the typical value.

# We can alleviate this problem by using a model that is robust to the 
#effect of outliers: MASS::rlm()
mod3 <- MASS::rlm(n ~ wday*term, data=daily)

daily %>% 
  add_residuals(mod3, "resid") %>% 
  ggplot(aes(date, resid))+
  geom_hline(yintercept = 0, size=2, color = "red")+
  geom_line()

#  It’s now much easier to see the long-term trend, and the positive and negative outliers.

# Time of Year: An Alternative Approach---

#  In the previous section we used our domain knowledge (how the US
# school term affects travel) to improve the model. An alternative to
# making our knowledge explicit in the model is to give the data more
# room to speak. We could use a more flexible model and allow that to
# capture the pattern we’re interested in.

library(splines)
mod <- MASS::rlm(n ~ wday*ns(date,5), data=daily)

# ns(date, 5) → A natural spline with 5 degrees of freedom (DOF).
daily %>%
  data_grid(wday, date = seq_range(date, n = 13)) %>%
  add_predictions(mod) %>%
  ggplot(aes(date, pred, color = wday)) +
  geom_line() +
  geom_point()

# We see a strong pattern in the numbers of Saturday flights. This is
# reassuring, because we also saw that pattern in the raw data. It’s a
# good sign when you get the same signal from different approaches.


# R Markdown --------------------------------------------------------------

# R Markdown Cheat Sheet: available in the RStudio IDE under
# Help → Cheatsheets → R Markdown Cheat Sheet/R Markdown Reference Guide



# Graphics for Communication  with ggplot2 --------------------------------

# Using ggplot2 and ggrepel and viridis packages
install.packages("ggrepel")
library(tidyverse)

# 1. Good Labels
ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(colour = class))+
  geom_smooth(se=FALSE)+
  labs(
    title="Fuel efficiency generally decreases with engine size"
  )

# subtitle adds additional detail in a smaller font beneath the title
# caption adds text at the bottom right of the plot, often used to
# describe the source of the data
ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(colour = class))+
  geom_smooth(se=FALSE)+
  labs(
    title="Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports car) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov"
  )

#  labs() to replace the axis and legend titles.
ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(colour = class))+
  geom_smooth(se=FALSE)+
  labs(
    x = "Engine Displacement (L)",
    y = "Highway Fuel Econmy (mpg)",
    colour = "Car Type"
  )

# use mathematical equations instead of text strings
?plotmath

df <- tibble(
  x=runif(10),
  y=runif(10)
)

df

# quote doesnt evaluate, it stores it as expression
ggplot(df, aes(x,y))+
  geom_point()+
  labs(
    x=quote(sum(x[i]^2, i==1, n)),
    y=quote(aplha+beta+frac(delta, theta))
  )

#  label it on the plot using geom_text and geom_label
# the most efficient car

# row_number() == 1: Picks the first row in each group (i.e.,
# the car with the highest highway mileage in that class)
best_in_class <- mpg %>% 
  group_by(class) %>% 
  filter(row_number(desc(hwy))==1)

best_in_class

ggplot(mpg, aes(displ,hwy))+
  geom_point(aes(colour = class))+
  geom_text(data = best_in_class, aes(label=model))


ggplot(mpg, aes(displ,hwy))+
  geom_point(aes(colour = class))+
  geom_label(data = best_in_class, aes(label=model, alpha=0.5))

# Highlighting our required points to see better
ggplot(mpg, aes(displ,hwy))+
  geom_point(aes(colour = class))+
  geom_point(data=best_in_class, size=7, shape=1)+
  geom_text(data = best_in_class, aes(label=model))

# ggrepel package removes the overlapping
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_point(size = 3, shape = 1, data = best_in_class) +
  ggrepel::geom_label_repel(
    aes(label = model),
    data = best_in_class
  )

class_avg <- mpg %>% 
  group_by(class) %>% 
  summarise(
    displ=median(displ),
    hwy=median(hwy)
  )

ggplot(mpg, aes(displ, hwy, colour = class))+
  ggrepel::geom_label_repel(
    data=class_avg, aes(label=class, size=6)
  )+
  geom_point()+
  theme(legend.position = "none")

label<- mpg %>% 
  summarise(
    displ=max(displ),
    hwy=max(hwy),
    label="Increasing engine size is \nrelated to decreasing fuel economy"
  )

ggplot(mpg, aes(displ, hwy))+
  geom_point()+
  geom_text(
    data=label,
    aes(label=label, vjust="top", hjust="right")
  )

# ---scales----

#  ggplot2 automatically adds default scales behind the scenes
ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(color=class))

# Behind the scenes
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  scale_x_continuous() +
  scale_y_continuous() +
  scale_color_discrete()

# Axis Ticks and Legend Keys
ggplot(mpg, aes(displ, hwy)) +
  geom_point()


ggplot(mpg, aes(displ, hwy))+
  geom_point()+
  scale_y_continuous(breaks =seq(15,40, by=5))

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_x_continuous(labels = NULL) +
  scale_y_continuous(labels = NULL)

# when each US president started and ended their term
presidential

# The geom_segment() function in ggplot2 is used to draw line segments
# between two points on a graph.
?scale_x_date

presidential %>% 
  mutate(id=33+row_number()) %>% 
  ggplot(aes(start, id))+
  geom_point()+
  geom_segment(aes(xend = end, yend=id))+
  scale_x_date(name=NULL,breaks=presidential$start, date_labels = "'%y")
  
# Legend Layout
#  To control the overall position of the legend, you need to use a theme() setting
# they control the nondata parts of the plot.

base <- ggplot(mpg,aes(displ,hwy))+
  geom_point(aes(colour=class))

base

base + theme(legend.position = "left")
base + theme(legend.position="right") # the default
base + theme(legend.position="top")
base + theme(legend.position = "bottom")
base + theme(legend.position="none")

# To control the display of individual legends, use guides() along
# with guide_legend() or guide_colorbar() 
base2 <- ggplot(mpg, aes(displ,hwy))+
  geom_point(aes(colour=class))+
  geom_smooth(se=FALSE)+
  theme(legend.position = "bottom")

base2

# color = guide_legend(...) → Specifies how the legend for the color aesthetic should be displayed.
# nrow = 1 → Arranges the legend items in a single row instead of multiple rows.
# override.aes = list(size = 4) → Adjusts the size of legend key points 
# (dots representing different class values) to size 4, making them more visible
base2 + guides(colour=guide_legend(nrow=1, override.aes = list(size=3)))

# Replacing a Scale
# Instead of just tweaking the details a little, you can replace the scale altogether
ggplot(diamonds, aes(carat, price)) +
  geom_bin2d()

#  However, the disadvantage of this transformation is that the axes are
# now labeled with the transformed values, making it hard to interpret.
ggplot(diamonds, aes(log10(carat), log10(price)))+
  geom_bin_2d()

# alternative
ggplot(diamonds, aes(carat, price))+
  geom_bin2d()+
  scale_x_log10()+
  scale_y_log10()


# Changing palette
# colorbrewer2.org

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv))

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  scale_color_brewer(palette = "RdPu")

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  scale_color_brewer(palette = "Set1")

# When you have a predefined mapping between values and colors,
# use scale_color_manual()
presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, color = party)) +
  geom_point() +
  geom_segment(aes(xend = end, yend = id)) +
  scale_colour_manual(
    values = c(Republican = "red", Democratic = "blue")
  )

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv, shape = drv)) +
  scale_color_brewer(palette = "Set1")

# scale_color_viridis() provided by the viridis
install.packages("viridis")

df <- tibble(
  x=rnorm(10000),
  y=rnorm(10000)
)

ggplot(df, aes(x,y))+
  geom_hex()+ coord_fixed()

ggplot(df, aes(x,y))+
  geom_hex()+
  viridis::scale_fill_viridis()+
  coord_fixed()

# Zooming

# To zoom in on a region of the plot, it’s generally best to use coord_cartesian()
ggplot(mpg, mapping=aes(displ,hwy))+
  geom_point(aes(colour = class))+
  geom_smooth()

# Alternative 1
# The first plot (using coord_cartesian()) will have a smoother trend line
# because it considers all data before zooming.
# Reducing the limits is basically equivalent to subsetting the data
ggplot(mpg, mapping=aes(displ,hwy))+
  geom_point(aes(colour = class))+
  geom_smooth()+
  coord_cartesian(xlim=c(5,7), ylim=c(10,30))

# Alternative 2
# The second plot (using filter()) might have a different smoothing curve 
# since it only considers a subset of the data
mpg %>% 
  filter(displ>=5, displ<=7, hwy>=10, hwy<=30) %>% 
  ggplot(aes(displ,hwy))+
  geom_point(aes(colour = class))+
  geom_smooth()

# suv
suv <- mpg %>% filter(class == "suv")

ggplot(suv, aes(displ, hwy, color = drv)) +
  geom_point()

#compact
compact <- mpg %>% filter(class == "compact")

ggplot(compact, aes(displ, hwy, color = drv)) +
  geom_point()

#  it’s difficult to compare the plots of suv and compact because
# all three scales (the x-axis, the y-axis, and the color aesthetic) have
# different ranges:

# training the scales with the limits of the full data
x_scale <- scale_x_continuous(limits=range(mpg$displ))
y_scale <- scale_y_continuous(limits=range(mpg$hwy))
col_scale <- scale_colour_discrete(limits=unique(mpg$drv))

ggplot(suv,aes(displ,hwy, color=drv))+
  geom_point()+
  x_scale+y_scale+col_scale

ggplot(compact, aes(displ, hwy, color = drv)) +
  geom_point() +
  x_scale +
  y_scale +
  col_scale

# Alternative if we don't want these plots on next page.
library(gridExtra)

p1 <- ggplot(suv, aes(displ, hwy, color = drv)) +
  geom_point()

p2 <- ggplot(suv, aes(displ, hwy, color = drv)) +
  geom_point()

grid.arrange(p1,p2, ncol=1)

# but it didnt change axes
# lets use facet_wrap()

# This gives 2 plots having comparable axes, however together.
mpg %>% 
  filter(class %in% c("suv", "compact")) %>% 
  ggplot(aes(displ,hwy, colour=drv))+
  geom_point()+
  facet_wrap(~class)

# Wrong approachh
# class %in% c("suv", "compact") returns TRUE or FALSE (Boolean values)
ggplot(mpg, aes(displ,hwy, colour=drv))+
  geom_point()+
  facet_wrap(~class %in% c("suv", "compact"))

# If you really want to use logical filtering inside facet_wrap(), 
# you must convert TRUE/FALSE to proper labels:
ggplot(mpg, aes(displ, hwy, colour = drv)) +
  geom_point() +
  facet_wrap(~ ifelse(class %in% c("suv", "compact"), as.character(class), "other"))
# Filtering earlier is better, is it gives 3 plots.

# Themes--
#  customize the nondata elements of your plot with a theme:
#gplot2 includes eight themes by default

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE)

# white background with frid lines
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_bw()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE)+
  theme_void()

# Saving Your Plots

# 1. ggsave()
# 2. knitr. ggsave()

# I am ending this learning project here.
# I will be able to do things like R markdown, saving plots specifically in pdf, 
# uploading a data etc when I will be in complet practice.

# project ends-------------
