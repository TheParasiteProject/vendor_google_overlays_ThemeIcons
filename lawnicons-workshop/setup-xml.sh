#!/usr/bin/bash

function check() {
	if [[ ! -f all_drawables.txt ]] ||
		[[ ! -f drawables_to_change.txt ]] ||
		[[ ! -f grayscale_icon_map-template.xml.txt ]] ||
		[[ ! -f packages.txt ]]; then
		echo "This script must be executed"
		echo "under vendor/google/overlays/ThemeIcons/lawnicons-workshop"
		echo "by ./setup-xml.sh !"
		exit 1
	fi
}

check

OUT="out"
XML_OUT="$OUT/xml/grayscale_icon_map.xml"
XML_TMP="grayscale_icon_map-template.xml.txt"
XML_TARGET="../PixelLauncherIconsOverlay/res/xml/grayscale_icon_map.xml"

rm $XML_TARGET
cp $XML_TMP $XML_TARGET

sed -i '/<?xml version="1.0" encoding="utf-8"?>/d' $XML_OUT
sed -i '/<icons>/d' $XML_OUT
sed -i '/<\/icons>/d' $XML_OUT

cat $XML_OUT >>$XML_TARGET
echo "</icons>" >>$XML_TARGET

unset XML_TARGET
unset XML_SRC
unset OUT
