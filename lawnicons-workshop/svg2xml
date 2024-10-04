#!/usr/bin/bash

function check() {
	if [[ ! -f all_drawables.txt ]] ||
		[[ ! -f drawables_to_change.txt ]] ||
		[[ ! -f grayscale_icon_map-template.xml.txt ]] ||
		[[ ! -f packages.txt ]]; then
		echo "This script must be executed"
		echo "under vendor/google/overlays/ThemeIcons/lawnicons-workshop"
		echo "by ./svg2xml !"
		exit 1
	fi
}

function proc_done() {
	echo "Process done"
}

function set_var() {
	SRC="src"
	WRK="wrk"
	OUT="out"
}

function unset_var() {
	unset OUT
	unset WRK
	unset SRC
}

function clean() {
	rm -Rf $WRK
	rm -Rf $OUT
}

function create_dir() {
	mkdir -p $WRK
	mkdir -p $OUT
}

function clone_lawnicons() {
	if [[ ! -d "$SRC/lawnicons/.git" ]]; then
		git clone https://github.com/LawnchairLauncher/lawnicons.git "$SRC/lawnicons"
		cd "$SRC"
		ln -sf "lawnicons/svgs" "svgs"
		ln -sf "lawnicons/app/assets/appfilter.xml" "appfilter.xml"
		cd ../
	else
		cd $SRC/lawnicons
		git fetch origin
		git pull origin develop
		cd ../../
	fi
}

function svg_optim() {
	local SVG="$SRC/svgs"
	local OPT="$WRK/svgs-opt"

	mkdir -p $OPT
	svgo -f $SVG -o $OPT
}

function conv_drw() {
	local DRW="$OUT/drawable"
	local OPT="$WRK/svgs-opt"

	mkdir -p $DRW
	vd-tool -c -in $OPT -out $DRW -addHeader
}

function rm_dup_drw() {
	local DRW="$OUT/drawable"

	for i in $(cat all_drawables.txt); do
		file_to_remove="$DRW/${i}.xml"
		if [[ -f $file_to_remove ]]; then
			rm $file_to_remove
		fi
	done
}

function create_xml() {
	local APPFILTER_SRC="$SRC/appfilter.xml"
	local XML_WRK_DIR="$WRK/xml"
	local XML_WRK="$WRK/xml/grayscale_icon_map.xml"
	local XML_DIR="$OUT/xml"
	local XML="$OUT/xml/grayscale_icon_map.xml"

	mkdir -p $XML_WRK_DIR
	mkdir -p $XML_DIR

	cat >$XML_WRK <<EOF
<?xml version="1.0" encoding="utf-8"?>
<icons>
</icons>
EOF

	while IFS= read -r raw; do
		resRaw=(${raw//;/ })
		drawable="@drawable/${resRaw[1]}"
		packageRaw=${resRaw[0]}
		package=$(echo ${packageRaw%/*} | cut -d'{' -f 2)

		xmlstarlet ed -L \
			-s "/icons" -t elem -n iconTMP \
			-i "//iconTMP" -t attr -n drawable -v $drawable \
			-i "//iconTMP" -t attr -n package -v $package \
			-r "//iconTMP" -v "icon" \
			$XML_WRK
	done < <(xmlstarlet sel -t -m "//item" -v "@component" -o ";" -v "@drawable" -n $APPFILTER_SRC)

	xmlstarlet fo -s 4 $XML_WRK >$XML_WRK.bak
	awk '!seen[$0]++' $XML_WRK.bak >$XML_WRK
	rm $XML_WRK.bak

	for i in $(cat packages.txt); do
		sed -i "/$i/d" $XML_WRK
	done

	for i in $(cat drawables_to_change.txt); do
		arr=(${i//|/ })
		src=${arr[0]}
		dest=${arr[1]}
		sed -i "s/\"@drawable\/$src\"/\"@drawable\/$dest\"/g" $XML_WRK
	done

	mv $XML_WRK $XML
}

function copy_output() {
	local DRW_SRC="$OUT/drawable"
	local DRW_TARGET="../PixelLauncherIconsOverlay/res-lawnicons"

	rm -rf "$DRW_TARGET/drawable"
	cp -rf $DRW_SRC $DRW_TARGET/

	bash ./setup-xml.sh
}

check

set_var

clone_lawnicons

clean
create_dir

svg_optim
conv_drw
rm_dup_drw
create_xml

copy_output

clean
unset_var

proc_done
