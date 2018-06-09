# Following are the functions used in Pubmed Affiliations project


# Split the text at ","
coma <- function(target){
    temp <- str_split(target, ",")
    str_trim(temp[[1]], side="both")
}


# Function to remove anything after ";"
semicolon <- function(target){
    temp <- str_locate(target, ";")[1,1]
    temp <- str_sub(target, 1, temp-1)
    str_trim(temp, side = "both")
}


# Function to remove email ids
email <- function(target){
    firstAt <- str_locate(target, "@")[1,1]
    allSpaces <- str_locate_all(target, " ")[[1]][,1]
    spacePrecedingFirstAt <- max(allSpaces[allSpaces<firstAt])
    temp <- str_sub(target, 1, spacePrecedingFirstAt)
    str_trim(temp, side = "both")
}


# Function to remove any numbers (0-9), symbols (-/\\-'\"&()), periods (.) in the text
numbers <- function(target){
    temp <- str_remove_all(target, "[0-9.-/\\-'\"&()]")
    str_trim(temp, side = "both")
}


# To view the summary of the xml file with info on nodes, attributes and much more.
crossCheckOutput <- function() {
    dataSummary <- xmlElementSummary(url = FileLocation)
    noOfArticles <-
        dataSummary$nodeCounts[names(dataSummary$nodeCounts) == "PubmedArticle"]
    noOfAffiliations <-
        dataSummary$nodeCounts[names(dataSummary$nodeCounts) == "Affiliation"]
    data.frame(
        "Original_File" = c(noOfArticles, noOfAffiliations, noOfAffiliations),
        "After_Mining" = c(length(PMID), length(Affiliations), c(length(country))),
        row.names = c("Articles", "Affiliations", "Countries")
    )
}


mining <- function(temp1) {
    
    name <- c()
    if (str_detect(temp1, "[,]")) {
        temp2 <- coma(temp1)
    } else {
        temp2 <- temp1
    }
    temp2
    
    for (c in length(temp2):1)
    {
        temp3 <- temp2[c]
        temp3
        if(is.null(temp3))
        {
            break
        }
        if (is.character(temp3) & !is.na(temp3)) {
            if (str_detect(temp3, "[;]")) {
                temp3 <- semicolon(temp3)
            } else {
                temp3 <- temp3
            }
        }
        temp3
        if (is.character(temp3) & !is.na(temp3)) {
            if (str_detect(temp3, "[@]")) {
                temp3 <- email(temp3)
            } else {
                temp3 <- temp3
            }
        }
        temp3
        if (is.character(temp3) & !is.na(temp3)) {
            if (str_detect(temp3, "[0-9.-/\\-'\"&()]")) {
                temp3 <- numbers(temp3)
            } else {
                temp3 <- temp3
            }
        } 
        temp3
        if(is.character(temp3) & !is.na(temp3)){
            temp3 <- str_split(temp3, " ")[[1]]
        } else {
            temp3 <- temp3
        }
        temp3
        
        if(is.na(temp3) | is.null(temp3)){
            next
        }
        
        for(d in length(temp3):1){
            if (length(cityCountry$Country[cityCountry$Country == temp3[d]]) > 0)
            {
                name <-
                    c(name, cityCountry$Country_Alias[cityCountry$Country == temp3[d]][1])
                temp2 <- NULL
                break
            } else if (length(cityCountry$City[cityCountry$City == temp3[d]]) > 0) {
                name <-
                    c(name, na.omit(cityCountry$Country_Alias[cityCountry$City == temp3[d]]))
                
            } else {
                name <- c(name, NULL)
            }
        }
    }
    name
}



# Dataframe of country and city names can be found in package "maps". I added few more.
# -------------------------------------------------------------------------------------

cityCountry <-
    data.frame(
        City = world.cities$name,
        Country = world.cities$country.etc,
        Country_Alias = world.cities$country.etc
    )
cityCountry$City <- as.character(cityCountry$City)
cityCountry$Country <- as.character(cityCountry$Country)
cityCountry$Country_Alias <-
    as.character(cityCountry$Country_Alias)
cityCountry <-
    rbind(
        cityCountry,
        c(NA, "United Kingdom", "UK"),
        c(NA, "Kingdom", "UK"),
        c(NA, "United States", "USA"),
        c(NA, "United States of America", "USA"),
        c(NA, "States", "USA"),
        c(NA, "America", "USA"),
        c(NA, "ROC", "China"),
        c(NA, "Republic of China", "China"),
        c(NA, "People's Republic of China", "China"),
        c(NA, "PR China", "China"),
        c(NA, "Wallis", "Wallis and Futuna"),
        c(NA, "Futuna", "Wallis and Futuna"),
        c(NA, "Republic of Korea", "South Korea"),
        c(NA, "North Korea", "North Korea"),
        c(NA, "Arabia", "Saudi Arabia"),
        c(NA, "UAE", "United Arab Emirates"),
        c(NA, "Arab", "United Arab Emirates"),
        c(NA, "Connecticut", "USA"),
        c(NA, "Sahara", "Western Sahara"),
        c(NA, "Vatican", "Vatican City"),
        c(NA, "Turks", "Turks and Caicos"),
        c(NA, "Caicos", "Turks and Caicos"),
        c(NA, "Trinidad", "Trinidad and Tobago"),
        c(NA, "Tobago", "Trinidad and Tobago"),
        c(NA, "Svalbard", "Svalbard and Jan Mayen"),
        c(NA, "Mayen", "Svalbard and Jan Mayen"),
        c(NA, "Lanka", "Sri Lanka"),
        c(NA, "Africa", "South Africa"),
        c(NA, "Solomon", "Solomon Islands"),
        c(NA, "Sierra", "Sierra Leone"),
        c(NA, "Leone", "Sierra Leone"),
        c(NA, "Serbia", "Serbia and Montenegro"),
        c(NA, "Montenegro", "Serbia and Montenegro"),
        c(NA, "Marino", "San Marino"),
        c(NA, "Vincent", "Saint Vincent and The Grenadines"),
        c(NA, "Grenadines", "Saint Vincent and The Grenadines"),
        c(NA, "Lucia", "Saint Lucia"),
        c(NA, "Pierre", "Saint Pierre and Miquelon"),
        c(NA, "Miquelon", "Saint Pierre and Miquelon"),
        c(NA, "Kitts", "Saint Kitts and Nevis"),
        c(NA, "Nevis", "Saint Kitts and Nevis"),
        c(NA, "Helena", "Saint Helena"),
        c(NA, "Rico", "Puerto Rico"),
        c(NA, "Puerto", "Puerto Rico"),
        c(NA, "Papua", "Papua New Guinea"),
        c(NA, "Guinea", "Papua New Guinea"),
        c(NA, "Mariana", "Northern Mariana Islands"),
        c(NA, "Zealand", "New Zealand"),
        c(NA, "Norfolk", "Norfolk Island"),
        c(NA, "Antilles", "Netherlands Antilles"),
        c(NA, "Marshall", "Marshall Islands"),
        c(NA, "Ivory", "Ivory Coast"),
        c(NA, "Man", "Isle of Man"),
        c(NA, "Guernsey", "Guernsey and Alderney"),
        c(NA, "Alderney", "Guernsey and Alderney"),
        c(NA, "Polynesia", "French Polynesia"),
        c(NA, "Guiana", "French Guiana"),
        c(NA, "Falkland", "Falkland Islands"),
        c(NA, "Faroe", "Faroe Islands"),
        c(NA, "Guinea", "Equatorial Guinea"),
        c(NA, "Salvador", "El Salvador"),
        c(NA, "Easter", "Easter Island"),
        c(NA, "Timor", "East Timor"),
        c(NA, "Dominican", "Dominican Republic"),
        c(NA, "Czech", "Czech Republic"),
        c(NA, "Rica", "Costa Rica"),
        c(NA, "Cook", "Cook Islands"),
        c(NA, "Congo", "Congo Democratic Republic"),
        c(NA, "African", "Central African Republic"),
        c(NA, "Cayman", "Cayman Islands"),
        c(NA, "Verde", "Cape Verde"),
        c(NA, "Canary", "Canary Islands"),
        c(NA, "Burkina", "Burkina Faso"),
        c(NA, "Bosnia", "Bosnia and Herzegovina"),
        c(NA, "Herzegovina", "Bosnia and Herzegovina"),
        c(NA, "Antigua", "Antigua and Barbuda"),
        c(NA, "Barbuda", "Antigua and Barbuda"),
        c(NA, "American", "American Samoa"),
        c(NA, "Samoa", "American Samoa")
        # British virgin island
        # us virgin island
        # korea north
        # korea south
    )

# To get more lists for city and country details, try the following:
# http://www.geonames.org/export/
# https://www.maxmind.com/en/free-world-cities-database


# Finding out number of Affiliations Per PMID which will be used in creating the FinalTable
# If we look at the pattern of the elements in xml file, to reach the Authors, we should pass PubmedArticle>MedlineCitation>Article>AuthorList. So, we need to find the number of authors in the AuthorList for each pubmedArticle.
no.ofAffiliationsPerPMID <- function() {
    temp <-
        getNodeSet(data,
                   "//PubmedArticle/MedlineCitation/Article/AuthorList")
    lengthtemp <- length(temp)
    No.ofAffiliationsPerPMID <- c()
    for (i in 1:lengthtemp) {
        temp1 <- xmlSize(temp[[i]])
        temp2 <- c()
        for (j in 1:temp1) {
            temp2 <- c(temp2, names(getChildrenStrings(temp[[i]][[j]])))
        }
        No.ofAffiliationsPerPMID <-
            c(No.ofAffiliationsPerPMID, sum(as.integer(temp2 == "AffiliationInfo")))
    }
    No.ofAffiliationsPerPMID
}










