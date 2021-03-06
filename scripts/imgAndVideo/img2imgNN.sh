# DESCRIPTION
# Resizes an image of type T (via parameter $1) in a path, by nearest-neighbor method, to target format F ($2), at size A x B ($3 x $4). (Nearest neighbor method will keep hard edges, or look "pixelated.") Uses GraphicsMagick, unless the file is ppm format, and in that case it uses IrfanView.

# DEPENDENCIES
# GraphicsMagick and/or IrfanView, both in your $PATH.

# USAGE
# NOTE that as this auto-switches to IrfanView as needed, it supersedes the now deleted irfanView2imgNN.sh and allIrfanView2imgNN.sh scripts.
# Run this script with the following parameters
# - $1 source file.
# - $2 destination format
# - $3 scale by nearest neighbor method to pixels X
# - $4 Optional. Force this Y-dimension, regardless of aspect. Scales by nearest neighbor method to pixels Y. ONLY USED for ppms. Ignored for all other types (aspect kept). SEE COMMENTS in i_view32.exe code lines area for options to maintain aspect and/or rotate image (wanted for my purposes at times).
# Example command:
#    img2imgNN.sh input.ppm png 640
# OR, to force a given x by y dimension for a ppm:
#    img2imgNN.sh input.ppm png 640 480


# CODE
imgFileNoExt=${1%.*}
imgFileExt=${1##*.}
targetFileName=$imgFileNoExt.$2
if [ ! -f $targetFileName ]; then
	# if source file is ppm, use IrfanView or graphicsmagic
	# (uncomment your preference) to convert.
	if [ $imgFileExt == ppm ]; then
		echo converting ppm file via i_view32 . . .
		# re: http://www.etcwiki.org/wiki/IrfanView_Command_Line_Options
		# NOTE that with an MSYS2 terminal (maybe it would happen with Cygwin also),
		# it simply opened the image in irfanview, unless I provide the escaped double-quote
		# marks in the below command. ?
			# ROTATE 90 DEGREES OPTION; uncomment next line (used with other options) :
		# extraIrfanViewParam1="/rotate_r"
			# FORCE ARBITRARY DIMENSIONS (aspect) by passing /resize_long=$3 AND /resize_short=$4
		i_view32.exe "$1 /resize_long=$3 /resize_short=$4 $extraIrfanViewParam1 /convert=$targetFileName"
			# MAINTAIN ASPECT OPTION:
		# i_view32.exe "$1 /resize_long=$3 /aspectratio $extraIrfanViewParam1 $extraIrfanViewParam2 /convert=$targetFileName"
	# otherwise use graphicsmagic:
	else
		echo converting image via GraphicsMagick . . .
		# If params $3 or $4 were not passed to the script, the command will simply be empty where they are (on the following line of code), and it should still work:
		gm convert $1 -scale $3 $targetFileName
	fi
	echo converted to $targetFileName . .
else
	echo target file $targetFileName already exists\; skipping.
fi