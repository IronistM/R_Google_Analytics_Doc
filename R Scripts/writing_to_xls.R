# Start getting the information! ------------------------------------------
require("dataframes2xls")
for (i in accounts)
{ 
  tmp_goals <- get_goals(account.id = i)
  tmp_profiles <- get_profiles(account.id = i)
  tmp_webproperties <- get_webproperties(account.id = i)
  # Let's write the results to files
  # Attempt 1 : csv
  #   write.csv(tmp_goals, file = paste0("ga_goals_",i,".csv"))
  #   write.csv(tmp_profiles, file = paste0("ga_profiles_",i,".csv"))
  #   write.csv(tmp_webproperties, file = paste0("ga_webproperties_",i,".csv"))
  # Attempt 2 : xls files
  write.xls(c(tmp_webproperties,tmp_profiles,tmp_goals), file=paste0("ga_doc_",i,".xls"))
}