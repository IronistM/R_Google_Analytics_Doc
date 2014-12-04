--------------Initiate RGA
# Install RGA from CRAN with: ----------------------------------------------
install.packages("RGA")
# Initiate RGA
library(RGA)

# Connect to API ----------------------------------------------------------
# get access token
ga_token <- authorize(client.id = "YOUR_CLIENT_ID", client.secret = "YOUR_CLIENT_SECRET")

# Get the accountIDs ------------------------------------------------------
# get the unique accountIDs
accounts <- unique(get_profiles()$"accountId")
websiteUrl <- unique(get_profiles()$"websiteUrl")
# Segments are user owned so this will only generate your segments (created by you or copied) and the default segments
# Google analytics provides, let's peek into them
head(get_segments())
# However goals are shared so this is an implementation material to share and store in the documentation. Let's take a look
head(get_goals())
