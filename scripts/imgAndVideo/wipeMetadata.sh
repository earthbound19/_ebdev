# Pass this script one paramater, being $1 a file name to wipe the metadata from in-place. WARNING: Do this only on backed up data. If something goes wrong with this, permanent kablooey for the affected files.

exiftool -CommonIFD0= -adobe:all= -xmp:all= -photoshop:all= -iptc:all= -m -overwrite_original -k $1