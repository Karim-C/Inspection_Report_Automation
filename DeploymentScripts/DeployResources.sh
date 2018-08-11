#!/bin/bash

stty -echo
printf "Please enter your Github token: "
read token
stty echo
printf "\n"

gitrepo= "https://github.com/Karim-C/Inspection_Report_Automation.git"
# add GitHub access token as env variable
webappname=InspetionReportTest$RANDOM

# Create a resource group.
az group create --location westeurope --name myResourceGroup

# Create an App Service plan in `FREE` tier.
az appservice plan create --name $webappname --resource-group myResourceGroup --sku FREE

# Create a web app.
az webapp create --name $webappname --resource-group myResourceGroup --plan $webappname

# Configure continuous deployment from GitHub. 
# --git-token parameter is required only once per Azure account (Azure remembers token).
az webapp deployment source config --name $webappname --resource-group myResourceGroup \
--repo-url $gitrepo --branch master --git-token $token --app-working-dir ./report-inspection-client

# Copy the result of the following command into a browser to see the web app.
echo Follow the following url to the site:
echo http://$webappname.azurewebsites.net