# Retrieve C02 distribution data from world bank development indicators dataset for the year 2010
Library(WDI)
wdi_data <- WDI(indicator=c("EN.ATM.CO2E.PC"),start=2010,end=2010,extra=TRUE)

#  Create a tibble dataframe object With the retrieved data
wdi_data = as_tibble(wdi_data)

# rename the original C02 indicator name to Distr_CO2percap
wdi <- wdi_data %>% rename(Distr_CO2percap=EN.ATM.CO2E.PC)
head(wdi)
# Import maps library 
# install.packages("maps")
library(maps)

# creates map information dataframe to be used later for ggplot2 plot 
dat_map <- map_data("world")

# Import countrycode library
# install.packages("countrycode")
library(countrycode)

# insert country codes from countrycode library into dat_map dataframe based on the region column
dat_map$ccode<- countrycode(dat_map$region, origin="country.name",destination="wb")
head(dat_map)
# similarly, insert country codes from countrycode library into wdi dataframe based on the country column
wdi$ccode <- countrycode(wdi$country,origin="country.name",destination="wb")
head(wdi)
# Perform a full join on the dat_map and wdi dataframe on the common column ccode
merged <- full_join(dat_map, wdi, by="ccode")
head(merged)

# Create a ggplot2 plot with geom_polygon() geom visualisation with long and lat datapoints as x and y axis 
# respectively.Also, set fill variable as Distr_C02percap to show distribution amongst countries 
ggplot(merged,aes(x=long,y=lat,group=group,fill=Distr_CO2percap))+ 
  geom_polygon()+
  ggtitle('Global Distribution of C02 per capita')




