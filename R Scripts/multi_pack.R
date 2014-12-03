# multi_pack function: install and load multiple R packages.
# check to see if packages are installed. Install them if they are not, then load them into the R session.
# changed name but really copied from Steven Worthington gist (https://gist.github.com/stevenworthington/3178163)

multi_pack <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}