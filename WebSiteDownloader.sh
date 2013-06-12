#!/bin/bash
clear
echo "Welcome to the WebSite Downloader!"
echo "----------------------------------"
echo ""
echo "Please enter your site to download:"
read Website
echo "How many pages of recursion would you like? (1-5)"
read webpagesDeep
if [ "$webpagesDeep" -gt 5 ]; then
	echo "[ERROR] You gave: $webpagesDeep, unknown value. Defaulting to 5."
	webpagesDeep=5;
fi

#echo "[DEBUGGING] Site: $Website"
#echo "[DEBUGGING] Recursion: $webpagesDeep"

echo "[RECCOMENDATION] Get a drink. This will take a while..."
echo "Press enter to continue ..."
read stuff

wget -r -l $webpagesDeep -np -E $Website
#-r  recursion on
#-l  recursion depth
#-p  page requistites
#-np no parent
#-E  adjust extension (get rid of PHP)

#echo "Downloading COMPLETED!"
#echo ""

