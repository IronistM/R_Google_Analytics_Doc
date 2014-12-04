# Now we can merge them in order to run some
# diagnostics. Taken from
# http://psychwire.wordpress.com/2011/06/03/merge-all-files-in-a-directory-using-r-into-a-single-dataframe/
setwd("reports/")

# this list the files
file_list <- list.files()

for (file in file_list)
{
  # if the merged dataset doesn't exist, create it
  if (!exists("dataset"))
  {
    dataset <- read.xls(file, header=TRUE, sep="\t")
  }
  # if the merged dataset does exist, append to it
  if (exists("dataset"))
  {
    temp_dataset <-read.xls(file, header=TRUE, sep="\t")
    dataset<-rbind(dataset, temp_dataset)
    rm(temp_dataset)
  }
}
