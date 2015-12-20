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
sum(col.div0.counts>0)
# 33
sum(cols.with.blanks[col.div0.counts>0])
# 33 # i.e. all of the columns with div0 errors also contain a large number of blanks

## create reduced data set that eliminates incomplete columns
train2 <- data.frame(training)[which(!(cols.with.nas|cols.with.blanks))]
