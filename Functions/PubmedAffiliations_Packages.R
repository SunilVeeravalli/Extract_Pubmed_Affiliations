# packages to be installed and attached
# --------------------------------------
# The following packages are to be installed 
# tidyverse
# maps
# XML

# Checking and installing "tidyverse" package
if(length(grep("^tidyverse$", installed.packages(), ignore.case = T))==0) {
    install.packages("tidyverse")
    library(tidyverse)
} else {
    library(tidyverse)
}

# checking and installing "maps" package
if (length(grep("^maps$", installed.packages(), ignore.case = T)) == 0) {
    install.packages("maps")
    library(maps)
} else {
    library(maps)
}

# checking and installing "XML"package
if (length(grep("^XML$", installed.packages(), ignore.case = T)) == 0) {
    install.packages("XML")
    library(XML)
} else {
    library(XML)
}

# checking and installing "tcltk"package
if (length(grep("^tcltk$", installed.packages(), ignore.case = T)) == 0) {
    install.packages("tcltk")
    library(tcltk)
} else {
    library(tcltk)
}
