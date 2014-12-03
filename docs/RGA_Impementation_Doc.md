#### Do I need an Implementation document?

One of most frustrating things that you can face during a day is someone to ask you to give her the definitions of the funnel that was configured a couple of years ago for 10 product categories. the only thing that can help you in this is to have an **Implementation document**. Oh, you bet you have it updated! (*side-note*: with the spread of Google Drive people tend to create documents for fun, however they rarely get to update them or even revisit them).


God, you definitely need to have written down  

1. What you are measuring for
2. What the configuration for the views are
3. What is that special thing you have opted in for this view? 

#### How we gonna do this fast?
After you run this code, you’ll have an Excel file that has all the following configuration point noted down

1. Accounts
2. Web Properties
2. Views
3. Goals
4. Segments
5. Custom Data Sources
6. Events

The utility that enables us to get 1-4 is the [Google Analytics Management API](https://developers.google.com/analytics/devguides/config/mgmt/v3/). To get the events we will need to employ the [Core API](https://developers.google.com/analytics/devguides/reporting/core/v3/) and get actual data (this means that if we track events that are not firing they will be not present in the documentation).

The Management API (v3) exposes multiple Google Analytics configuration entities. Most are organized hierarchically: 

- Each user's Account can have one or more Web Properties, each of which can have one or more Views (Profiles) or Custom Data Sources.
- Each user's Account can also have one or more Filters. 
- Views (Profiles) can have one or more Goals, Unsampled Reports or Experiments, and Custom Data Sources can have one or more Uploads. Unsampled Reports are available for Google Analytics Premium customers only.
- There are also entities that allow users to manage user permissions by creating a User Link at the Account, Web Property, or View (Profile) level. 
- Similarly, AdWords Links can be constructed at the Web Property level. 
- Filters can be connected to a particular View (Profile) with a Profile Filter Link. A user can also define Segments, which are not hierarchically related to any of the other entities. This diagram represents the parent-child relationships among the entities:

![Google Analytics Management API](https://developers.google.com/analytics/images/gaManagementModel.png)


#### Limitations of the Management API

We cannot get some interesting stuff with the API

1. Channel groupings
2. Brand keywords
3. Enhanced eCommerce settings
4. Events
5. Custom dimensions/metrics

to name a few.

#### Another R Google Analytics API package...
Let's go on and load a new package that enables us to connect to the Google Analytics various APIs, [RGA](https://bitbucket.org/unikum/rga/overview), all capitals since there is another package with lowercase [rga](https://github.com/skardhamar/rga).

I will not go through the details on how to get authenticated on Google Console as it is well explained in the package repository. 

The main functions we will need to create our implementation doc are

1. `get_accounts()`
2. `get_profiles()`
3. `get_segments()`
4. `get_webproperties()`
5. `get_custom_sources()`
6. `get_goals()`

#### Off to the real thing!
In the lines below we load the package and pass the `client.id` and `client.secret` to get authorised in the API. Once we done this we can get the the `views` (or `profiles` as we used to call them few months ago)

```r
# Initiate RGA ------------------------------------------------------------
# load package
library(RGA)

# Connect to API ----------------------------------------------------------
# get access token
ga_token <- authorize(client.id = "YOUR_CLIENT_ID", client.secret = "YOUR_CLIENT_SECRET")

# Get the accountIDs ------------------------------------------------------
# get the unique accountIDs
accounts <- unique(get_profiles()$"accountId")
> head(accounts)
[1] "183263"   "431217"   "4476693"  "7369781"  "22603640" "27175492"
```
Now, that we have the unique `accountIds` we can iterate over them (say in a `for()` loop) and get the elements needed.

We will create an excel file for each account we have. We could also modify this to work on a website (URL) level but let's make the assumption that we have things organised under one `accountIds` for each client. The workhorse of the excel file creations will be the [xlsx](http://cran.r-project.org/web/packages/xlsx/index.html) package and a modified wrapper function from [Robert I. Kabacoff](http://wp.me/p1b1HR-7V)


```r
# Start getting the information! ------------------------------------------
require(dataframes2xls)
require(devtools)
# We will need the following helper function
# to parse the websiteUrl in order to use it in our file naming
# It is adapted from this stackoverflow Q&A : http://stackoverflow.com/a/17286485
source_url("https://github.com/IronistM/R_Google_Analytics_Doc/raw/master/R%20Scripts/domain_name_function.R")
```

```r
for (i in 1:length(accounts))
{ 
  tmp_goals <- get_goals(account.id = accounts[i])
  tmp_profiles <- get_profiles(account.id = accounts[i])
  tmp_webproperties <- get_webproperties(account.id = accounts[i])
  # Let's write the results to files
  # Attempt 2 : xls files
    write.xls(c(tmp_webproperties,tmp_profiles,tmp_goals), file=paste0("ga_doc_",domain_name(websiteUrl[i]),".xls"))
}

```

#### Is that all to document for?

This only the basics of a Google Analytics Documentation other stuff you might consider adding to this like

1. The actual business questions that the implementation is aiming at
2. KPIs you are trying to optimise for
3. 
