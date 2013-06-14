#!/bin/bash

##########################################################
# Configuration:
# --------------
GermanWordlist=("Breite" "Herstellung" "Jagd" "Orient" "Gewicht" "Hieb" "Stichwaffen" "cm")
GermanBADlist=("Foto" "Druck" "Druckschriften" "Druckgraphik" "Fotografie" "Fotopapier" "Tischuhr")

SavedListToLookAt="BockusAwesomeLinks.txt"

Counter_BadPages=0
Counter_GoodPages=0
Counter_PagesSithKeyWords=0

#Would you like to see debug messages?
debug=false

rm $SavedListToLookAt

amount=`find . | grep -v ".git" | wc -l`
echo "[ArmorSpider] Parsing $amount File(s) for keywords"
#Now look through ALL the files downloaded, and save web pages to a list

counter=1
ItemCounter=0
echo "`find . | grep -v \".git\"`" > ListOfFiles.txt
ItemsToScan=`find .|wc -l`

x="lolololololol"
##########################################################

##########################################################
# Print Splash Screen:
# --------------------
clear
echo "   +-----------------------------------------"
echo "   :\". /  /  /"
echo "   :.-\". /  /         ARMOR SPIDER"
echo "   : _.-\". /             v 1.0"
echo "   :\"  _.-\"."
echo "   :-\"\"     \"."
echo "   :                        By:"
echo "   :                   Phrasz - 2013"
echo " ^.-.^"
echo "'^\\+/^\`"
echo "'/\`\"'\\\`"

echo "[ArmorSpider] Super Awesome Armor Finder..."
echo ""

echo "[ArmorSpider] Looking for ${#GermanWordlist[@]} words"
echo "[ArmorSpider] Banned ${#GermanBADlist[@]} words"
echo "[ArmorSpider] Press enter to continue..."
read pressentertocontinue
##########################################################



##########################################################
# Spider Logic:
# -------------
#Look for page title within ALL Pages with Keywords
while read WebPage; do
	clear
	echo " ^.-.^"
	echo "'^\\+/^\`      Crawling ..."
	echo "'/\`\"'\\\`"
	echo "[ArmorSpider] Current Stats:"
	echo "[ArmorSpider] Bad: $Counter_BadPages"
	echo "[ArmorSpider] Good: $Counter_GoodPages"
	echo "[ArmorSpider] Keyword Pages: $Counter_PagesSithKeyWords"
	echo ""

	echo "[$counter / $ItemsToScan] Looking at $WebPage"
	Title=`cat "$WebPage" | grep "<class=\"dbtitle\">"` #Pull the title if it has one
	if [ "$x"!="$x$Title" ]; then #IF Title is NOT empty
		echo "Title of Artifact: $Title"
	fi

	notfound=true
	notBad=true

	for SearchWord in "${GermanBADlist[@]}"
	do
		if $notBad; then
			if $debug; then
				echo "[ArmorSpider] Searching for BAD word: $SearchWord"
			fi
			tempFinding=`cat "$WebPage" | grep "$SearchWord"`
			if [ "$x$tempFinding" != "$x" ]; then
				echo "Found: ${GermanBADlist[@]} in $WebPage"
				#echo "$WebPage" >> $SavedListToLookAt
				Counter_BadPages=$((Counter_BadPages + 1))
				notBad=false
			fi
		fi
	done


	if $notBad; then
		Counter_GoodPages=$((Counter_GoodPages + 1))

		for SearchWord in "${GermanWordlist[@]}"
		do

			if $notfound; then
				if $debug; then
					echo "[ArmorSpider] Searching for word: $SearchWord"
				fi
				tempFinding=`cat "$WebPage" | grep "$SearchWord"`
				if [ "$x$tempFinding" != "$x" ]; then
					echo "Found: ${GermanWordlist[@]} in $WebPage"
					echo "$WebPage" >> $SavedListToLookAt
					Counter_PagesSithKeyWords=$((Counter_PagesSithKeyWords + 1))
					notfound=false
				fi
				ItemCounter=$(( ItemCounter + 1))
			fi
		done
	fi

	counter=$((counter+ 1))
done < ListOfFiles.txt

rm ListOfFiles.txt
##########################################################
clear

echo "   +-----------------------------------------"
echo "   :\". /  /  /"
echo "   :.-\". /  /         ARMOR SPIDER"
echo "   : _.-\". /             v 1.0"
echo "   :\"  _.-\"."
echo "   :-\"\"     \"."
echo "   :                        By:"
echo "   :                   Phrasz - 2013"
echo " ^.-.^"
echo "'^\\+/^\`"
echo "'/\`\"'\\\`"
echo ""
echo "[ArmorSpider] Scanning Completed\! Final Stats:"
echo "[ArmorSpider] Bad: $Counter_BadPages"
echo "[ArmorSpider] Good: $Counter_GoodPages"
echo "[ArmorSpider] Keyword Pages: $Counter_PagesSithKeyWords"
Convert="Y"
echo ""
echo "[ArmorSpider] Would you like to attempt images to webpage conversion? [Y/n]"
read ConvertInput

if[ "$Convert" == "$Convert$ConvertInput" ]; then
	echo "[ArmorSpider] Attempting Conversion..."
fi
