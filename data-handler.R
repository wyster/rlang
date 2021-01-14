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
gender <- data %>% count(data$gender)
colnames(gender) <- c('name', 'count')
gender

# 1. Open jpeg file
jpeg(paste(getwd(), 'genders.jpg', sep = '/'), width = 350, height = 350)
# 2. Create the bar
barplot(gender$count, names.arg = gender$name, ylab = 'Rows')
# 3. Close the file
dev.off()
