# Coursera - Johns Hopkins - Practical Machine Learning
# 2015-12-15 first look at the project data

library(data.table)

training <- fread("~/Dropbox/personal/educational/JohnsHopkins_PracticalMachineLearning/pml-training.csv")
testing <- fread("~/Dropbox/personal/educational/JohnsHopkins_PracticalMachineLearning/pml-testing.csv")
nrow(training);nrow(testing)
# 19622; 20
ncol(training)
# 160

setdiff(names(testing),names(training))
# "problem_id"
setdiff(names(training),names(testing))
# "classe"

unique(training$classe)
# "A" "B" "C" "D" "E"

table(training$classe)

table(training$classe)
# A    B    C    D    E
# 5580 3797 3422 3216 3607

# seems there are two kinds of columns, those which are monstly NA and those with no missing data
unique(apply(training,2,function(x) sum(is.na(x))))
#   0 19216

# the fact that all colss with NAs have exactly the same number (19216) suggests that these columns
# are only populated by a subset of the data. This confirms it:
unique(apply(training[!is.na(avg_yaw_forearm),],2,function(x) sum(is.na(x))))
#  0

cols.with.nas <- unlist(lapply(training,function(x) any(is.na(x))))
sum(cols.with.nas)
# 67
rows.with.nas <- is.na(training$var_yaw_forearm)


## there are also columns with same large number of blanks
unique(apply(training,2,function(x) sum(x=="")))
# 0 19216 NA
unique(apply(training[amplitude_yaw_forearm!="",],2,function(x) sum(x=="")))
#  0
cols.with.blanks <- unlist(lapply(training,function(x) any(x=="")))
cols.with.blanks[cols.with.nas] <- FALSE
sum(cols.with.blanks)
#  33
rows.with.blanks <- training$amplitude_yaw_forearm==""

sum(rows.with.nas==rows.with.blanks)
# 19622