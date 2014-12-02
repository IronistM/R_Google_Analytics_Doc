# We will need the following helper function
# to parse the websiteUrl in order to use it in our file naming
# It is adapted from this stackoverflow Q&A : http://stackoverflow.com/a/17286485
domain_name <- function(urls) {
  require(httr)
  require(plyr)
  paths <- laply(urls, function(u) with(parse_url(u),
                                        paste0(hostname, "/", path)))
  gsub("^/?(?:www\\.)?([^/]+).*$", "\\1", paths)
}