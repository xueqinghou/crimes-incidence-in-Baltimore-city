

 
# clear everything
rm(list = ls()) 

# libraries 
#   need to install.packages() these
#   let me know if installation does not work
library(maps)
library(maptools)

# download, unzip and read the shape file
url_zip <- 'https://dl.dropboxusercontent.com/s/chyvmlrkkk4jcgb/school_distr.zip'
if(!file.exists('school_distr.zip')) download.file(url_zip, 'school_distr.zip')     # download file as zip
unzip('school_distr.zip')   # unzip in the default folder
schdstr_shp <- readShapePoly('school.shp')  # read shape file
xlim <- schdstr_shp@bbox[1,]
ylim <- schdstr_shp@bbox[2,]

# example of how to use the shape file
#   if there are no error code reading the above, you can directly plot the map of Baltimore (lines within are school districts)
#   we'll be overlaying our plots of crime incidents on this map:
plot(schdstr_shp, axes = T)     # axes = T gives x and y axes


# ======= now let's follow instructions in the pdf file ======

# download and load the crime csv data
#   link is https://dl.dropboxusercontent.com/s/4hg5ffdds9n2nx3/baltimore_crime.csv
library(readxl)
df <- read.csv("~/Desktop/programming/baltimore_crime (1).csv")
View(df)

latitude <- substr(baltimore_crime$Location1, start = 2, stop = 14 )
longitude <- substr(baltimore_crime$Location1, start = 16, stop = 29)
hour <- substr(baltimore_crime$CrimeTime, start = 1, stop = 2)
month <- substr(baltimore_crime$CrimeDate, start = 1, stop = 2) 
day <- substr(baltimore_crime$CrimeDate, start = 4, stop = 5)
year <- substr(baltimore_crime$CrimeDate, start =7 , stop = 10)

df <- data.frame(
  Location = baltimore_crime$Location,
  District = baltimore_crime$District,
  CrimeDate = baltimore_crime$CrimeDate,
  month = month,
  day = day,
  hour = hour,
  CrimeTime = baltimore_crime$CrimeTime,
  latitude = latitude,
  longitude = longitude,
  Description = baltimore_crime$Description
)
df

df <- df[grepl("ASSAULT", df$Description) == TRUE, ]


# transform dates and time variables depending on what you need
yearandmonth = df$CrimeDate
yearMonth = as.Date(yearandmonth, '%m/%d/%Y')
df$year = format(yearMonth,'%Y')
df$month = format(yearMonth,'%m')


# split coordinates into longitude and latitude, both as numeric
# note: no for/while/repeat loop
df$Location1 =  gsub("\\(", "", df$Location1)
df$Location1 =  gsub("\\)", "", df$Location1)
loc = strsplit(df$Location1,',',)

sapply(loc,`[`,1)


df$latitude = numeric(nrow(df))
df$longitude = numeric(nrow(df))

ll = function(x,n) unlist(x[n])
df$latitude = sapply(loc,function(x)ll(x,1))
df$longitude = sapply(loc,function(x)ll(x,2))


# baltimore_crime_1_$latitude = substr(baltimore_crime_1_$Location1,2,14)
# baltimore_crime_1_$longitude = substr(baltimore_crime_1_$Location1,16,29)

# generate geographic and time patterns for crimes with keyword "ASSAULT"
# note: no copy and paste of the same/similar command many times













