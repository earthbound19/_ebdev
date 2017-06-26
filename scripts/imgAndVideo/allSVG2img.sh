# DESCRIPTION: creates .jpg (by default) files from all .svg files in a directory tree, via imagemagick. Creates 4120px jpg images by default. Also, does not overwrite files if the render target name exists (you must first delete the existing target file, then run this script to re-create it).
# This script was formerly entitled allSVG2PNG.sh.

# USAGE: invoke this script with these parameters:
# $1 the number of pixels you wish the longest side of the converted .svg file(s) to be.
# $2 the target file format e.g. png or jpg -- defaults to jpg if not provided.
# $3 optional--include this parameter (it can be anything) to make white transparent; otherwise white will default to opaque.

# DEV NOTE: template command: gm -size 850 test.svg result.tif
# NOTE that for the -size parameter, it scales the images so that the longest side is that many pixels.

img_size=$1
img_format=$2

# If no image size parameter, set default image size of 4120.
if [ -z ${1+x} ]; then img_size=4120; else img_size=$1; fi
# If no image format parameter, set default image format of jpg.
if [ -z ${2+x} ]; then img_format=jpg; else img_format=$2; fi
# If no third parameter, make background transparent.
if [ -z ${3+x} ]; then param3="-background none"; fi
# if [ -z ${3+x} ]; then param3="-background white"; fi
# if [ -z ${3+x} ]; then param3="-background black"; fi
# if [ -z ${3+x} ]; then param3="-background #584560"; fi		# Darkish plum?
# if [ -z ${3+x} ]; then param3="-background #3b383c"; fi		# Medium-dark purplish-gray
# potentially good black line color change options: #2fd5fe #bde4e4
# NOTE: you may tweak that line to say "-background gray" to replace a transparent background with gray (if you leave off the third parameter when calling this script. Or instead of gray, any hex color code e.g. #555555. Otherwise, revert it to the default "-background none" to leave transparency in the resultant image.)

find . -iname \*.svg > all_svgs.txt
while read element
do
		svgFilenameNoExtension=`echo $element | sed 's/\(.*\)\.svg/\1/g'`
	if [ -a $svgFilenameNoExtension.$img_format ]
	then
		echo render candidate is $svgFilenameNoExtension.$img_format
		echo target already exists\; will not render.
		echo . . .
	else
		echo rendering $element . . .
		echo COMMAND\: gm convert $param3 -scale $1 $element $svgFilenameNoExtension.$img_format
		gm convert $param3 -scale $1 $element $svgFilenameNoExtension.$img_format
	fi
done < all_svgs.txt

rm all_svgs.txt