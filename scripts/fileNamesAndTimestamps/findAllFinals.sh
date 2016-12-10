# Lists all files that have the tag FINAL in them:
# cygwinFind . -type f -iregex '.*FINAL.*'


# USAGE
# Call this script from a path where you wish to list all files that include the string FINAL in them. If you wish instead to find all files that have the offset string _FINAL_ in them, pass this script any parameter.

# List ALL files, because the following command:
		# CygwinFind . -type f -iregex '.*FINAL.*' > ___ALL_FINALS___.txt
		# -- results in listing files that include '.*FINAL.*' in the *path* but not the file name (as well as all that have it in the file name).
CygwinFind . -type f > ___ALL_FINALS___.txt
# strip off paths, leaving only file names:
sed -i 's/.*\///g' ___ALL_FINALS___.txt
# remove all listings that end with _MD_ADDS.txt:
sed -i 's/.*_MD_ADDS.txt//g' ___ALL_FINALS___.txt
# remove any listing of ___ALL_FINALS___.txt if it existed before this script was executed:
sed -i 's/___ALL_FINALS___.txt//g' ___ALL_FINALS___.txt
# remove all listings that do not include the phrase FINAL; thx to http://stackoverflow.com/a/8255627/1397555 :
# Block template: if no such parameter this, otherwise that:
if [ -z ${1+x} ]
	then	# if no paramater passed to script, search for .*FINAL.* :
		sed -i -n 's/\(.*FINAL.*\)/\1/p' ___ALL_FINALS___.txt
	else	# if parameter passed to script, search for _FINAL_ :
		sed -i -n 's/\(.*_FINAL_.*\)/\1/p' ___ALL_FINALS___.txt
fi