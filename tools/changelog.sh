#!/bin/bash
# note: re-generating days is possible. Just delete the dates you want regenerated
# from the top (!!) of the changelog file in $OUT/system/etc/Changelog.txt
# 2nd line of the file must be the date to fetch from!!
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
NC="\033[0m"

export Changelog=Changelog.txt
export PassedDays=7 # change this to limit max changelog days
export MANIFEST="${TOP}/.repo/manifests/bliss.xml"

if [ -f "${OUT}/system/etc/${Changelog}" ] # if changelog already generated
then
	cp "${OUT}/system/etc/${Changelog}" $Changelog
	LastDate=$(sed '2!d' $Changelog) # get 2nd line of changelog file
	LastDate="$(echo -e "${LastDate}" | tr -d '[:space:]')" # get rid of whitespaces
	# extract month day and year from string:
	Month=${LastDate:0:2}
	Day=${LastDate:3:2}
	Year=${LastDate:6:4}
	LastDate=$(date -d "${Year}${Month}${Day}" +%s)
	TimeNow=$(date +%s) # current time
	DayDiff=$(( (TimeNow - LastDate) / 86400 )) # n/o days passed
	if [[ $DayDiff < $PassedDays ]]; then # don't fetch more than max days
		export PassedDays=$DayDiff
		mv $Changelog "${Changelog}.bak" # save current changelog for later
	fi
fi

touch $Changelog

if [[ $PassedDays == 0 ]]; then
	echo "Already have today"
	rm $Changelog{,.bak}
	exit 0
else
	echo -e "${GREEN}Regenerating log of last ${YELLOW}${PassedDays}${GREEN} days${NC}"
	if [ -f "${OUT}/system/etc/${Changelog}" ]; then
		rm "${OUT}/system/etc/${Changelog}" "${OUT}/${Changelog}"
	fi
fi

# Build a list of all repos
PROJECTPATHS=$(grep "<project" "${MANIFEST}" | sed -n 's/.*path="\([^"]\+\)".*/\1/p')

# Add repos in local manifest for DT changelog
for lManifest in $TOP/.repo/local_manifests/*; do
	PROJECTPATHS+=" $(grep "<project" "${lManifest}" | sed -n 's/.*path="\([^"]\+\)".*/\1/p')"
done

echo -e "${GREEN}Generating changelog...${NC}"

# Save current dir
pDIR=$(echo $PWD)

for i in $(seq $PassedDays);
do
	export After_Date=$(date --date="$i days ago" +%m-%d-%Y)
	export Until_Date=$(date --date="$(expr $i - 1) days ago" +%m-%d-%Y)

	# Line with after --- until was too long for a small ListView
	echo '====================' >> $Changelog;
	echo "     "$Until_Date     >> $Changelog;
	echo '====================' >> $Changelog;
	echo >> $Changelog;

	# Cycle through every repo to find commits between 2 dates
	for PROJECTPATH in ${PROJECTPATHS}; do
		[ ! -d "$TOP/$PROJECTPATH" ] && continue
		cd "${TOP}/$PROJECTPATH"
		if ! [[ -z $(git log --after=$After_Date --until=$Until_Date) ]]; then # only echo if there is a change
			echo "[${PROJECTPATH}]" >> $pDIR/$Changelog
			git log --format="%s <%ar> [%h]%nby: %an (%ae)" --after=$After_Date --until=$Until_Date >> $pDIR/$Changelog
			echo >> $pDIR/$Changelog
		fi
	done
	cd $pDIR
	echo >> $Changelog;
done

sed -i 's/project/   */g' $Changelog

if [ -f "${Changelog}.bak" ]
then
	cat "${Changelog}.bak" >> $Changelog # restore old changelog to the end of current one
fi

cp $Changelog $OUT/system/etc/
cp $Changelog $OUT/
rm -f $Changelog{,.bak}
