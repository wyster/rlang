library(dplyr)

# read from file
data <- read.table(
  paste(getwd(), 'data.txt', sep = '/'),
  header = TRUE,
  sep = "\t",
  quote = ""
)

# columns list
colnames(data)
# rows length
nrow(data)

# min, max ID
min(data$id)
max(data$id)

# handle gender
genders <- data %>% count(data$gender)
colnames(genders) <- c('name', 'count')
genders

# 1. Open jpeg file
jpeg(paste(getwd(), 'genders.jpg', sep = '/'), width = 350, height = 350)
# 2. Create the bar
barplot(genders$count, names.arg = genders$name, ylab = 'Rows', main = paste('Genders, Total:', sum(genders$count)))
# 3. Close the file
dev.off()

# handle countries
countries <- data %>% count(data$country)
colnames(countries) <- c('name', 'count')

otherCountriesMaxCount <- sum(countries$count) / 100

otherCountries <- countries %>% filter(countries$count <= otherCountriesMaxCount & countries$name != '')
withoutCountry <- countries %>% filter(countries$name == '')
countriesCount <- nrow(otherCountries)

countries <- countries %>% filter(countries$count >= otherCountriesMaxCount & countries$name != '')
countries <- merge(countries, list(name = 'Other', count = sum(otherCountries$count)), all = TRUE)
countries <- merge(countries, list(name = 'Without', count = sum(withoutCountry$count)), all = TRUE)

# 1. Open jpeg file
jpeg(paste(getwd(), 'countries.jpg', sep = '/'), width = 1200, height = 1000)
# 2. Create the bar
pie(countries$count, labels = paste(countries$name, '(', countries$count, ')'), main = paste('Countries, Total:', countriesCount))
# 3. Close the file
dev.off()
