# "XML" package is used to work with XML files.

# In .XML files, we see data enclosed between tags as shown below. For example:
# <dataset source="R Project" numRecords="32" name="mtcars">
#     <variables count="11">
#           <variable>cyl</variable>
#           <variable>disp</variable>
#           <variable>hp</variable>
#     </variables>
# </dataset>
#
# In the above example, dataset, variables, variable are called elements. Every element has a closing element with / in the beginning. The data between the opening and closing element is called value. For example, one opening element <variable> and its closing element </variable> has the value cyl in them. Also, elements will also have attributes. For dataset element, the attributes are source, numRecords and name. The attributes fro Variables is count.


# setting the working directory
# -----------------------------
# No need to set working directory because we created the project file (.RProj file) which will take care of setting the working directory.


# All the functions and packages used in this project are written in a separate file name "PubmedAffiliations_Functions.R" and "PubmedAffiliations_Packages.R" respectively. The source() command will load those functions for usage.
source(file = "Functions/PubmedAffiliations_Packages.R")
source(file = "Functions/PubmedAffiliations_Functions.R")


# choose the location of your target xml file when asked
# To show a popup message to user, use the package "tcktl". 
# checking and installing "tcltk"package
if (length(grep("^tcltk$", installed.packages(), ignore.case = T)) == 0) {
    install.packages("tcltk")
    library(tcltk)
} else {
    library(tcltk)
}
tk_messageBox(type = "ok", message = "In the next screen, please select the location of XML file that needs to be analyzed", caption = "Message")
FileLocation <- file.choose()

# Pulling the xml file to R
data <- xmlInternalTreeParse(file = FileLocation)

# We want to create a table with Pubmed ID (PMID) and all the affilations for each PMID
PMID <- xpathSApply(data, "//PubmedArticle/MedlineCitation/PMID", xmlValue)

Affiliations <- xpathSApply(data, "//PubmedArticle/MedlineCitation/Article/AuthorList/Author/AffiliationInfo/Affiliation", xmlValue)









# To pull country name out of Affiliations
# ----------------------------------------
# We need to pull the Country out of Affiliations
# For this "stringr" is being used that has already been installed with "tidyverse" installation

country <- data.frame()

for (a in 1:length(Affiliations)) {
    x <- c()
    y <- c()
    if (str_detect(Affiliations[a], "[;]"))
    {
        temp <- str_split(Affiliations[a], "[;]")[[1]]
        temp
        
        for (b in 1:length(temp))
        {
            temp1 <- temp[b]
            temp1
            x <- mining(temp1)
            x
            if(length(x[duplicated(x)])>0)
            {
                x <- unique(x[duplicated(x)])
                x
            } else {
                if(length(x)>0){
                    x <- x
                } else {
                    x <- NA
                }
            }
            y <- c(y, x)
            y
        }
    } else {
        temp1 <- Affiliations[a]
        temp1
        x <- mining(temp1)
        x
        if(length(x[duplicated(x)])>0)
        {
            x <- unique(x[duplicated(x)])
            x
        } else {
            if(length(x)>0){
                x <- x
            } else {
                x <- NA
            }
        }
        y <- c(y, x)
        y
        
    }
    for(i in 1:length(y)){
        country[a,i] <- y[i]
    }
}
colnames(country) <- c(paste("Country", seq(1:ncol(country))))
# country



# To find if extracting country name failed in some Affiliations
# which(is.na(country))
# Affiliations[which(is.na(country))]


# Check if there are errors while extracting the country name from Affiliations. If there are errors, then manually edit or write more functions if the error is seen with many Affiliations
# unique(country)


# Find out if the number of Pumbed Articles, Affiliations, Country you got while mining is equal to the actual number in the xml file. This is throwing an error if the xml file is huge.
# crossCheckTable <- crossCheckOutput(FileLocation)
# crossCheckTable


# Creating a final table with PMID, Affiliation, country Name
# The length of PMID will be different to the length of Affiliations because one PMID contains many Affiliations. So, find out the number of Affiliations each PMID has.

affiliationsPerPMID <- no.ofAffiliationsPerPMID()
# affiliationsPerPMID

# Now we create a table with PMID column and respective Affiliations column
FinalTable1 <- data.frame(PMID = rep(PMID, affiliationsPerPMID), Affiliations = Affiliations, Country = country)


FinalTable1 <- unique(FinalTable1)
# View(FinalTable1)

# The following table gives the International collaboration information
FinalTable2 <- unique(FinalTable1[,c(1,3:length(FinalTable1))])
# View(FinalTable2)

# sorting FinalTable2 to have one PMID per row
lenPMID <- length(PMID)
lenFinalTable2 <- length(FinalTable2)
FinalTable3 <- data.frame()
for (i in 1:lenPMID) {
    temp <- FinalTable2[FinalTable2$PMID == PMID[i], 2:lenFinalTable2]
    temp <- stack(temp)
    temp <- unique(na.omit(temp$values))
    lentemp <- length(temp)
    if (lentemp > 0) {
        for (j in 1:lentemp) {
            FinalTable3[i, 1] <- PMID[i]
            FinalTable3[i, j + 1] <- temp[j]
        }
    } else {
        FinalTable3[i, 1] <- PMID[i]
        FinalTable3[i, j + 1] <- NA
    }
}
rm(i, j, lenPMID, lenFinalTable2, lentemp)
names(FinalTable3) <- c("PMID", paste("Country_", 1:(length(FinalTable3)-1), sep = ""))
# View(FinalTable3)

# Save the FinalTable3 in csv format in the folder downloaded by the user
tk_messageBox(type = "ok", message = "The output is saved to the downloaded folder as Output.csv", caption = "Message")
write.csv(FinalTable3, file = "Output.csv", na = "", row.names = FALSE)


# things to do
# -------------
# add a * in the output where two cities have same name but are in different countries
# sort south korea, north korea, us virgin island, british virgin island filtering, 
# add date to the table so that we can find in a particular year, how the collaborations were





