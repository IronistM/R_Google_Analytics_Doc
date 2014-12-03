# Start getting the information! ------------------------------------------
require("dataframes2xls")
for (i in 1:length(accounts))
{ 
  tmp_goals <- get_goals(account.id = accounts[i])
  tmp_profiles <- get_profiles(account.id = accounts[i])
  tmp_webproperties <- get_webproperties(account.id = accounts[i])
  tmp_segments <- get_segments()
  tmp_custom_sources <- get_custom_sources()
  # Let's write the results to files
  # Attempt 2 : xls files
  write.xls(c(tmp_webproperties,tmp_profiles,tmp_goals,tmp_segments,tmp_custom_sources), file=paste0("ga_doc_",websiteUrl[i],".xls"))
}