#!/bin/bash
clear
website="http://www.dhm.de/datenbank/dhm.php?seite=5&fld_0=MI002762"
webpagesDeep=5 #Valid numbers: 1-5
GermanWordlist=("Breite" "Herstellung" "Jagd" "Orient" "Gewicht" "Hieb" "Stichwaffen") #"cm"
SavedListToLookAt="BockusAwesomeLinks.txt"
rm $SavedListToLookAt

echo "[ArmorSpider] Super Awesome Armor Finder..."
echo ""
echo "[ArmorSpider] Downloading ALL THE THINGS from: $website"
echo "[RECCOMENDATION] Get a drink. This will take a while..."
#download 5 pages deep of links from $website
#wget -E -l $webpagesDeep $website
echo "[ArmorSpider] Downloading COMPLETED!"
echo ""

amount=`find . | wc -l`
echo "[ArmorSpider] Parsing $amount File(s) for keywords"
#Now look through ALL the files downloaded, and save web pages to a list

counter=1
ItemCounter=0
echo "`find .`" > ListOfFiles.txt
ItemsToScan=`find .|wc -l`
#Look for page title within ALL Pages with Keywords
while read WebPage; do
	clear
	echo "[$counter / $ItemsToScan] Looking at $WebPage"
	Title=`cat "$WebPage" | grep "<class=\"dbtitle\">"` #Pull the title if it has one
	if [ x!=x$Title ]; then #IF Title is NOT empty
		echo "Title of Artifact: $Title"
	fi

	notfound=true

	for SearchWord in "${GermanWordlist[@]}"
	do
		if $notfound; then
			echo "[ArmorSpider] Searching for word: $SearchWord"
			tempFinding=`cat "$WebPage" | grep "$SearchWord"`
			if [ x$tempFinding!=x ]; then
				echo "Found: ${GermanWordlist[@]} in $WebPage"
				echo "$WebPage" >> $SavedListToLookAt
				notfound=false
			fi
			#grep -r "$SearchWord" . >> PagesFoundWithKeywords.txt
			ItemCounter=$(( ItemCounter + 1))
		fi
	done


###    echo "Entry $counter:"
# >> $SavedListToLookAt
# >> $SavedListToLookAt
    #   echo "Page to Look at: $WebPage" >> $SavedListToLookAt
    #   #Update List

	counter=$((counter+ 1))
done < ListOfFiles.txt

rm ListOfFiles.txt

