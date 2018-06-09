# Extract Pubmed Affiliations
Extract the country names from Pubmed affiliations and visualize the extent of worldwide collaborations among researchers. For this, you need to have R and RStudio installed on your computer and an XML file created from Pubmed.

## Creating and XML file form Pubmed

1. Go to [Pubmed](https://www.ncbi.nlm.nih.gov/pubmed)
<img src="Images/PubmedIndex.tif" Width="1000" />

2. Type the text in search bar and press **Search** button
<img src="Images/PubmedSearch.tif" width="1000" />

3. In the results page, click **Send to** and then choose **File** and Format as **XML**. Click on **Create File** and choose the destination to save the XML file.
<img src="Images/PubmedResult.tif" width="1000" />

## Working with R project

1. Open the PubmedAffiliationsProject folder and double click **PubmedAffiliationsProject.Rproj** file. It will open RStudio.

2. In the files pane of RStudio, click the script file **PubmedAffiliations.R**. Select entire script and press **Run**.

3. You will be asked for the location of **XML** file. Please select the location and press **OK**.

4. Once the extraction is done, you will be prompted that the output will be saved as **output.csv** in the **PubmedAffiliationsProject** folder.

5. Press **OK** and then open the **output.csv** file to see the results.

## Note

- Work in progress to visualize the data in the form of maps.

- Please revisit the repository in few days.


## Contributors

- Sunil Kumar Veeravalli <veeravallisunil@gmail.com>


## Copyright

&copy; Sunil Kumar Veeravalli