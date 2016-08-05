# View the structure of loan_data
str(loan_data)
# Load the gmodels package 
library(gmodels)
# Call CrossTable() on loan_status
CrossTable(loan_data$loan_status)

# Call CrossTable() on grade and loan_status
CrossTable(loan_data$grade, loan_data$loan_status, prop.r = TRUE, prop.c = FALSE,
           prop.t = FALSE, prop.chisq = FALSE)


library(magrittr)


count<-loan_data %>% group_by(grade) %>% summarize(count = n(loan_status))



hist(loan_data_ROT$annual_inc, sqrt(nrow(loan_data_ROT)),
     xlab = 'Annual Income')

2105.24-282.21


# Create histogram of loan_amnt: hist_1

hist_1<-hist(loan_data$loan_amnt)
# Print locations of the breaks in hist_1

print(hist_1$breaks)

# Change number of breaks and add labels: hist_2
hist_2 <- hist(loan_data$loan_amnt, breaks = 200, xlab = "Loan amount", 
               main = "Histogram of the loan")



?which()


# Plot the age variable
plot(loan_data$age, ylab = 'Age')


# Save the outlier's index to index_highage
index_highage<-which(loan_data$age == 122)

index_highage<-which(loan_data$age >= 122)
index_highage

# Create data set new_data with outlier deleted
library(dplyr)
new_data<-filter(loan_data, age < 122)



# Make bivariate scatterplot of age and annual income

plot(x= loan_data$age, y = loan_data$annual_inc, xlab = 'Age', ylab = "Annual Income")


na<- which(is.na(loan_data$variable)
          
new<-loan_data[-c(na),]



