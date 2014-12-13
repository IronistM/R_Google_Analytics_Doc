# Start getting the information! ------------------------------------------
require("dataframes2xls")

# Add an intro sheet
intro <- rbind("This is a technical report of your Google Analytics Impementation",paste("Updated at :", date()))

for (i in 1:length(accounts))
{
  tmp_goals <- get_goals(account.id = accounts[i])
  tmp_profiles <- get_profiles(account.id = accounts[i])
  tmp_webproperties <- get_webproperties(account.id = accounts[i])
  tmp_segments <- get_segments()
  tmp_custom_sources <- get_custom_sources()
  # Let's write the results to xls files
  write.xls(c(intro,tmp_webproperties,tmp_profiles,tmp_goals,tmp_segments,tmp_custom_sources), file=paste0("ga_doc_",websiteUrl[i],".xls"))
}
