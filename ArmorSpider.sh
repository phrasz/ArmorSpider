#!/bin/bash
clear

echo "   +-----------------------------------------"
echo "   :\". /  /  /"
echo "   :.-\". /  /"
echo "   : _.-\". /"
echo "   :\"  _.-\"."
echo "   :-\"\"     \"."
echo "   :"
echo "   :"
echo " ^.-.^"
echo "\'^\\+/^\`"
echo "'/`\"'\\`"

GermanWordlist=("Breite" "Herstellung" "Jagd" "Orient" "Gewicht" "Hieb" "Stichwaffen") #"cm"
GermanBADlist=("Foto" "Druck" "Druckgraphik" "Fotografie" "Fotopapier") #"cm"

SavedListToLookAt="BockusAwesomeLinks.txt"
rm $SavedListToLookAt

echo "[ArmorSpider] Super Awesome Armor Finder..."
echo ""

echo "[ArmorSpider] Looking for ${#GermanWordlist[@]} words"
echo "[ArmorSpider] Banned ${#GermanBADlist[@]} words"
echo "[ArmorSpider] Press enter to continue..."
read pressentertocontinue

amount=`find . | wc -l`
echo "[ArmorSpider] Parsing $amount File(s) for keywords"
#Now look through ALL the files downloaded, and save web pages to a list

counter=1
ItemCounter=0
echo "`find .`" > ListOfFiles.txt
ItemsToScan=`find .|wc -l`

x="lolololololol"
#Look for page title within ALL Pages with Keywords
while read WebPage; do
	clear
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
			echo "[ArmorSpider] Searching for BAD word: $SearchWord"
			tempFinding=`cat "$WebPage" | grep "$SearchWord"`
			if [ "$x$tempFinding" != "$x" ]; then
				echo "Found: ${GermanBADlist[@]} in $WebPage"
				echo "$WebPage" >> $SavedListToLookAt
				notBad=false
			fi
		fi
	done

	if $notBad; then
		for SearchWord in "${GermanWordlist[@]}"
		do
			if $notfound; then
				echo "[ArmorSpider] Searching for word: $SearchWord"
				tempFinding=`cat "$WebPage" | grep "$SearchWord"`
				if [ "$x$tempFinding" != "$x" ]; then
					echo "Found: ${GermanWordlist[@]} in $WebPage"
					echo "$WebPage" >> $SavedListToLookAt
					notfound=false
				fi
				ItemCounter=$(( ItemCounter + 1))
			fi
		done
	fi

	counter=$((counter+ 1))
done < ListOfFiles.txt

rm ListOfFiles.txt

