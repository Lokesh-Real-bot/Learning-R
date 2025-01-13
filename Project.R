#Creating a dataframe from our dataset Header = TRUE, IndexColumn = 1st Column.
mydata <- read.csv("~/R Data/opsd_germany_daily.txt", row.names="Date")
mydata

#looking at the part of a data frame using head() and tail().
head(mydata)

tail(mydata)

#View data in a a tabular format 
View(mydata)

#Retrieve the dimensions of the data
dim(mydata)

#Check datatype of each column. (DATE COLUMN WONT BE SHOWD SINCE ITS INDEX COLUMN AND USEFUL)
str(mydata)

#Looking the date column (Wont be shows would occur as null)
head(mydata$Date)

#Lokking at the row.names i.e. indexes
row.names(mydata)

#Accessing a specific row in the data frame. we will use square brackets and will open space for column by sing a comma.
mydata["2006-01-01",]
mydata["2017-08-10",]

#Accessing multiple rows using concatenation.
mydata[c("2006-01-01", "2017-08-10"),]

#Deriving the summary of the datasset.
summary(mydata)

#Importing data without parsing the date column. Here I using the button an not some code.
#I will leave the row names as none
mydata2 <- read.csv("~/R Data/opsd_germany_daily.txt")
View(mydata2)

#Now I can see the date column as the indexation has been removed
head(mydata2$Date)

#Now We see the structure of the data
str(mydata2$Date)

#Convert it into date format.
x = as.Date(mydata2$Date)
head(x)
class(x)
str(x)

#Extracting year, month and day from th date. "Y" would be Capital. "m" and "d" would be small.
year = as.numeric(format(x,"%Y"))
head(year)

month = as.numeric(format(x,"%m"))
head(month)

day = as.numeric(format(x, "%d"))
head(day)

#Checking the both dataframes
head(mydata2)
head(mydata)

#Adding the columns to our new dataset.
mydata2 <- cbind(mydata2, year, month, day)
head(mydata2)



#Checking we have 8 columns with no index column in our final dataset 2
head(sample(mydata2,8))


#Let's Create a line plot of thee full time series of Germany's daily electricity conssumption.
#Using Dataframe's PPlot method.

#Using Plot

#Option 1 
plot(mydata2$year, mydata2$Consumption, type = "l", xlab = "Year", ylab = "Consumption")

#Option 2. Giving a a good range to Y and X axis.  Not using a dashed line so lty=1
plot(mydata2$year, mydata2$Consumption, type="l", xlab = "Year", ylab = "Consumption", 
     lty=1, xlim = c(2006,2018), ylim = c(800,1700))

#Better Options. Since we cannot understand the graph properly
#First We notice that we have only graph to be shown in 1 page. One plot in a window.
#So par(mfrow=c(1,1))

par(mfrow=c(1,1))

#Option3. Using second column of our dataframe.
plot(mydata2[,2])

#Option 4. Describing some more details. Type is Line graph. Line thickness(lwd=2)

plot(mydata2[,2], xlab="Year", ylab = "Conssumption", type="l", lwd=2, col="Blue")

#Option5. Our Final line graph with Limits. title is Consumption Graph

plot(mydata2[,2], xlab="Year", ylab="Consumption", type="l", lwd=2,
     xlim=c(2006,2018), ylim = c(900,2000), main="Consumption Graph")

#Taking Log values and their difference to make our plot more meaningful. Ylimits acc to log
plot(10*diff(log(mydata2[,2])), xlab="Year", ylab = "Consumption", type="l",
     lwd=2, ylim=c(-5,5), main="Consumption Graph", col="Orange")

#Using ggplot()
install.packages("ggplot2")
library(ggplot2)

#Option1 "o" : a point shape where "o" represents a circle
ggplot(mydata2,type="o")+geom_line(aes(x=year,y=Consumption))

#Option2. instructing the plot to group data points based on a variable in your dataset,
#where the unique value is "1", essentially treating all rows with that "1" value 
# as belonging to the same group
ggplot(data = mydata2, aes(x=year,y=Consumption, group = 1))+geom_line()+geom_point()

#Option3.
ggplot(data = mydata2, aes(x=year,y=Consumption, group = 1))+geom_line(linetype="dashed")+geom_point()

#Option4,.
ggplot(data = mydata2, aes(x=year,y=Consumption, group = 1, col = "Red"))+geom_line()+geom_point()

#Option5
ggplot(data=mydata2, mapping = aes(x=year,y=Consumption, col="Red"))+geom_point()

#We can see that the plot() method was chosen pretty good locations-
#every 2 years and labels the years for the x axis which is helpful.
#However with so many data points, the line plot is crowded and hard to read
#Thus we can go with the plot() with some more data modifications.

#Check the column numbers using the head.

head(mydata2)

#Check the max and minimum values.
#Helpful when we have multiple graphs
#Helpful to determine our limit range

#Wind Column. 3rd Column. Remove null values
min(mydata2[,3], na.rm=T)
max(mydata2[,3], na.rm=T)

#Consumption Column. 2nd Column.
min(mydata2[,2], na.rm=T)
max(mydata2[,2], na.rm=T)

#Solar. 4th Column
min(mydata2[,4], na.rm=T)
max(mydata2[,4], na.rm=T)

#Wind + Solar
min(mydata2[,5], na.rm=T)
max(mydata2[,5],na.rm=T)

#For Multiple Plots. Charts having 3 Rows and 1 Column
par(mfrow=c(3,1))

plot1 <- plot(mydata2[,2], xlab=year, ylab="Daily Totals (Gwh)", type="l", 
              lwd=2, main="Consumption", col='Orange')

#Bringing Year, Limits setting according to min and max of consumption.
plot1 <- plot(mydata2[,2], xlab="Year", ylab="Daily Totals (Gwh)", type="l", 
              lwd=2, main="Consumption", col='Orange', ylim=c(840,1750))

#Tried a lot to put date in x-axis but couldn't. 
#First Checked if it has gone NA, NOOOOOO
#Somehow it was converted back to character 
#So Converting date column back to date format first
#Though its is different from the  learnings.

mydata2$Date <- as.Date(mydata2$Date, fomat = "%m/%d/%Y")
str(mydata2$Date)

plot1 <- plot(mydata2[,1],mydata2[,2], xlab="Year", ylab="Daily Totals (Gwh)", type="l", 
              lwd=2, main="Consumption", col='Orange', ylim=c(840,1750))

#Plots for wind, solar etc
plot2 <- plot(mydata2[,3], xlab ="Year", ylab ='Daily Totals (Gwh)', type="l",
              lwd=2, main="Wind", ylim = c(0,900), col= "Blue")

plot3 <- plot(mydata2[,4], xlab="Year", ylab ='Daily Totals (Gwh)', type ="l",
              lwd=2, main="Solar", ylim = c(0,500), col="Red")

#From the Charts we get to know
#1. It is seasonal Consumption gets highest at a particular time.
# Then it drops down. 
#2. Electricity consumption appears to split into two clusters, one with oscillations
#centered around 1400Gwh and another with fewer and more scattered data points, centered
#around 1150Gwh. We might guess these clusters correspond to weekdays and weekends.
#Solar Poer is higher in Summer 
#Wind Power is higher in Winter 
#Electricity consumption is higher in winter due to use of electric heating.
#All the 3 time series show seasonality.


#1 Plot in a window

par(mfrow=c(1,1))

#Let's plot time series in a single year to investigate further
str(mydata2)
x <- as.Date(mydata2$Date)
head(x)
class(x)
str(x)

#To Convert date column into date format
moddate <- as.Date(x, format = "%m/%d/$Y")
str(moddate)

# Creating our new dataframe. mydata3 will be our copmlete data with one more column
# the moddate column
mydata3 <- cbind(moddate, mydata2)
head(mydata3)
str(mydata3)

#Lets extract data for a particular year. mydata4 will have subsets.
#Foe either year or months.
mydata4 <- subset(mydata3, subset = mydata3$moddate >= '2017-01-01'  & 
                    mydata3$moddate <= '2017-12-31')

head(mydata4)

#Lets Plot mydata4
plot4 <- plot(mydata4[,1],mydata4[,3], xlab='Year', ylab='Daily Totalas (Gwh)',
              type="l", lwd=2, main='Consumption', col="Orange")

# Understanding this graph
# 1. More Consumption during Jan-March and Oct-Jan
# 2. Weekly oscillations of consumption
# 3. Drastic decline in consumption during early January and Late December
#  Assuming this decline due to holidays.


# Zooming in further for Jan and Feb Data. So now mydata4 is subset for 2 months
mydata4 <- subset(mydata3, subset = moddate >= '2017-01-01'
                  & moddate <= '2017-02-28')
head(mydata4)
str(mydata4)

plot4 <- plot(mydata4[,1], mydata4[,3], xlab='Year', ylab='Daily Totals(Gwh)',
              type='l', lwd=2,  main='Consumption', col="Orange")

# Deriving max and min to set limits for Jan and Feb
xmin <- min(mydata4[,1], na.rm=TRUE)
xmax <- max(mydata4[,1], na.rm=TRUE)
xmin
xmax

ymin <- min(mydata4[,3], na.rm=TRUE)
ymax <- max(mydata4[,3], na.rm=TRUE)
ymin
ymax

plot4 <- plot(mydata4[,1], mydata4[,3], xlab="Year", ylab='Daily Totals(Gwh)',
              type='l', lwd=2, main="Consumption", col="Orange",
              xlim=c(xmin,xmax), ylim=c(ymin,ymax))

#Adding a grid. Adding Horizontal(h) Lines.
grid()
abline(h=c(1300,1500,1600))

#Adding vertical(v) lines which are dashed (lty=2). sequence at min and max
# Having an interval of 7(weekly).
abline(v=seq(xmin,xmax,7), lty=2, col="Blue")

# Noticing the weekly consumption
# Art the end of the week it drops and gets high in somewhere mid of weekdays.

# ----------------

#Now to represent seasonality we will use box-plots.
#Coming back to our full data mydata3

boxplot(mydata3$Consumption)
boxplot(mydata3$Wind)
boxplot(mydata3$Solar)

#But these simple box plots doesn't give a meaning.
#Except we see some outliers for wind data.

# Boxplot is a visual display of 5 number summary.
# smallest data value, the first quartile, the median,
#the third quartile, and the largest data value.


# We can see the vector for those 5 numbers here.
# We will also get the limits for our boxplot.
quantile(mydata3$Consumption, probs = c(0, 0.25, 0.5, 0.75, 1))

#Creating the box plot with limits.
# No need to put data specifically for x axis (i.e any date column).
# As we will show only one graph
boxplot(mydata3$Consumption, ylab="Consumption", main="Consumption",
        ylim=c(600,1800))

#Creating box-plots Yearly.
#Grouped based on Year.
# Now 2 or more graphs will come so need to specify x axis. here "Years"
boxplot(mydata3$Consumption ~ mydata3$year, main='Consumption',
        ylab='Consumption', ylim=c(600,1800), xlab="Years")

#Argument las
#By default las=0. it means labels will be parallel to their axes.
# las=1. It makes all labels of both axes horizontal
# las=2. It makes labels go to right at angles with their axes.
# las=3. It makes all labels vertical

#In our cae we will make all labels horizontal. so las=1
boxplot(mydata3$Consumption ~ mydata3$year, main='Consumption',
        ylab='Consumption', ylim=c(600,1800), xlab="Years", las=1)


# Box-Plotting Monthly
boxplot(mydata3$Consumption ~ mydata3$month, main="Consumption",
        xlab="Monthly", ylab="Conssumption", ylim=c(600,1800), las=1)

# Multiple plots in a window. Monthly for wind solar and consumption.
par(mfrow=c(3,1))

boxplot(mydata3$Consumption ~ mydata3$month, main="Consumption",
        xlab="Monthly", ylab="Consumption", ylim=c(600,1800), las=1, col="Red")


boxplot(mydata3$Wind ~ mydata3$month, main="Wind",
        xlab="Monthly", ylab="Wind", ylim=c(0,900),
        las=1, col="Blue")

boxplot(mydata3$Solar ~ mydata3$month, main="Solar",
        xlab="Monthly", ylab = "Solar", ylim=c(0,200),
        las=1, col="Green")

# Understanding the monthly boxplots 
# 1. Consumption
# a. Electricity Consumption is higher in Winter and lower in summer.
# b. Median and lower quartiles in dec and jan are lower than Nov and feb due to holidays.

# 2. Wind and Solar Power
# a. Seasonality in production
# b. Wind power has many outliers due to storms and other transient weather conditiions.

# Creating Boxplots, Grouping daywise, 1plot/window
par(mfrow=c(1,1))

#Consumption daywise
boxplot(mydata3$Consumption ~ mydata3$day, main="Consumption",
        xlab="Days", ylab="Consumption", ylim=c(600,1800),
        las=1, col="Green")

#If we create the boxplot as weeends and weekdays.
#  we will infer more consumption on weekdays and less on weekends
# The outliers on weekdays are extra holidays on weekdays.

#-------------


# Frequencies
# Using frequency in data and after understanding the pattern
# We can take care of the missing values.

#If we see our data, the moddate is in a sequence.
mydata3

#Deriving sums after removing na values. Too work better here use dplyr
install.packages("dplyr")
library(dplyr)

#We see the min, max etc
summary(mydata3)

# How  many entries dos the columns have.
# How many na are there.  is.na brings na values. their sum is total Na in a column
# We will derive the Sum of columns After removing the Na values too. !is.na removes na and bring others.

#Sum of columns without Na
colSums(!is.na(mydata3))

# We notice that moddate, dates and consumption have 4383 but wind solar etc have less.
# This shows that they must contain Na values.

#total Na values in consumption
sum(is.na(mydata3$Consumption))

#total Na values in Wind
sum(is.na(mydata3$Wind))

#total Na values in Power
sum(is.na(mydata3$Solar))

#total na values in wind+solar
sum(is.na(mydata3$Wind.Solar))


# Now **Applying Frequencies** 

#moddate. day wise frequency of date
xmin <- min(mydata3[,1], na.rm=TRUE)
xmin

#I want to see frequence of moddate from minimum value, daywise till 5 entries.
freq1 <- seq(from=xmin, by="day", length.out=5)
freq1

#freq1 shows yes there is day-wise frequency.

typeof(freq1)
class(freq1)

#Month wise frequency of date
freq2 <- seq(from=xmin, by="month", length.out=5)
freq2

#freq2 shows yes there is month-wise frequency.

#Year wisse frequency of date
freq3 <- seq(from=xmin, by="year", length.out=5)
freq3

#freq3 shows yes there is year-wise frequency too.

# Now we want to auto fill the na values in wind column
# For that we will do something :)

# Selecting the data which has na values for wind, Using 'which', 'names' to create subsets.
# Which will show where are the na values in wind column.
# When used without assignment, names(object) returns a character vector -
# containing the names of the elements within the object.
# It is possible to update just part of the names attribute via the general rules
# Using concatenation to bring only moddate, wind, solar and consumption.
# %in% is piping, also known as "and then"

#So we are basically selecting the na values through which,
#Along with that we are bringing selected columns through "Names"

wind1 <- mydata3[which(is.na(mydata3$Wind)),
                 names(mydata3) %in% c("moddate", "Consumption", "Wind", "Solar")]
wind1
View(wind1)

#Lets select the data which doesnt have na valles for wind.
wind2 <- mydata3[which(!is.na(mydata3$Wind)),
                 names(mydata3) %in% c('moddate', "Consumtion", "Wind", "Solar")]
wind2
View(wind2)

# Looking ata the result of the above two, we know that 2011 has some missing values.
# Basically we know the data. To ease our filling we will go for 2011.

# In R, "==" is used to check if two values are equal (comparison operator), 
# while "=" is used to assign a value to a variable (assignment operator);

#Selecting data for 2011
wind3 <- mydata3[which(mydata3$year == "2011"), 
                 names(mydata3) %in% c("moddate", "Wind", "Solar", "Consumption")]
wind3[1:10,]

# Looking at the data we notice there are some vales for wind
# So Concluding 2011 has both missing and not missing values for wind.

class(wind3)
View(wind3)

#So now we have 'wind3' dataframe showing data for 2011 having both na and not na

# Finding the  number of na values in a particular year (2011)
sum(is.na(wind3[,3]))

#or
sum(is.na(mydata3$Wind[which(mydata3$year == "2011")]))

#Finding the total number of  non na values in 2011 for wind
sum(!is.na(wind3$Wind))

# Total values 1+364 =365 which is for a year.

str(wind3)

#  Finding where the na values is in for 2011 for wind.

wind4 <- wind3[which(is.na(wind3$Wind)),
               names(wind3) %in% c("moddate", "Consumption", "Wind", "Solar")]
wind4

# Noticing there was only 1 na value in 2011 for wind.
# And that occurs on 2011-12-14

# Now we will align this na value with 1 upper and one lower non-na value.
# Which means 2 more rows for 2011-12-13 and 2011-12-15.

test1 <-  wind3[which(wind3$moddate > "2011-12-12" & wind3$moddate < "2011-12-16"),
                names(wind3) %in% c("Consumption", "Wind", "Solar", "moddate")]
test1

# now its very easy to see 3 data.
# To refl;; or replace the na value.
class(test1)
str(test1)

# Using library tidyr to fill the na 
# We can fill the na values with any direction
# Using up, down, rightt, left
# Noting that the data are in frequency, if not first convert it into a frequency.
# Here it is in frequency day-wise. to be used.

install.packages("tidyr")
library(tidyr)

#Default direction (down). Wind's W is capital
test1 %>% fill(Wind)
# It filled the values of upwards to down

# Direction (Upwards)
test1 %>% fill(Wind, .direction = "up")



#---------------------------


# Trends
# An easy way to visualize these trends of slow variability and higher frequency variability (seasonality and noise).

# A "rolling mean," also called a moving average,
# is a statistical calculation used to identify trends in data by averaging values over a specific time window.

# It tends to smooth a time series by averaging out variations-
# at frequencies much higher than the window size and averaging out any seasonality-
# On a time scale equal to window size.

# This allows lower frequency data to be explored.

#Since our electricity consumption time series has weekly and yearly seasonality.
# Lets look at the rolling means on those 2 scales.

#Installing zoo package for rolling means
install.packages("zoo")
library(zoo)

# Coming back to our full data of mydaata3
mydata3

#Arranging and grouping the data using dplyr
#And then mutate function will allow to use the rolling mean.
# Rolling mean every 3 days here on consumption column
#Taake care of tthe NA values. fill=na
testroll <- mydata3 %>%
  dplyr::arrange(desc(year)) %>%
  dplyr::group_by(year) %>%
  dplyr::mutate(roll_3days = zoo::rollmean(Consumption, k=3, fill =NA)) %>%
  dplyr::ungroup()

testroll

#Understanding this data
# 1. The first value in our roll_3days (1367) is the mean of  1st,2nd and 3rd value of consumptiion column
# Checking 
mean(c(1130,1441,1530))

# 2. The second value in our roll_3days (1508) is the mean of 2nd, 3rd and 4th value of consumption column
# Checking
mean(c(1441,1530,1553))

# Lets calculate the weekly (7day) rolling mean and yearly(365) rolling mean

testroll2 <- mydata3 %>%
  dplyr::arrange(desc(year)) %>%
  dplyr::group_by(year) %>%
  dplyr::mutate(roll_7days = zoo::rollmean(Consumption, k=7, fill=NA),
                roll_365days = zoo::rollmean(Consumption, k=365, fill=NA)) %>%
  dplyr::ungroup()

testroll2

# Checking the testroll2 with some filters. Till 7 rows
testroll2 %>%
  dplyr::arrange(moddate) %>%
  dplyr::filter(year=="2017") %>%
  dplyr::select(Consumption, moddate, year, roll_7days:roll_365days) %>%
  utils::head(7)

# We can check data for a particular column too
testroll2$roll_7days

testroll2$roll_365days

#Plotting of our rolling means
par(mfrow=c(1,1))

# 1. We will plot the normal consumption data
# 2. We will put the second plot (rolling means) in the same plot using points
# 3. Legend argument is used to identify 2 different plots

plot(testroll2$Consumption, xlab="Year", ylab="Conssumption", type="l",
     lwd=2, col="blue", main="Consumption graph")

points(testroll2$roll_7days, type="l", lwd=2, 
       xlim=c(2000,2018), ylim=c(900,2000), col="orange")

points(testroll2$roll_365days, type="l", lwd=10,
       xlim=c(2000,2018), ylim=c(900,2000), col="green")

legend("topright", legend=c("testroll2$Consumption", "testroll2$roll_7days",
                           "testroll2$roll_365days"), col=c("blue",  "orange", "green"),
       pch = c("o","*","+"), lty=c(1,2,3), ncol=1, cex=0.7)


#---Similarly we can see the trend of wind and solar data


#----Prroject Ends