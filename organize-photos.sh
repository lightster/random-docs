# requires exiftool

find Unprocessed -type f -print0 | xargs -0 -I {} exiftool -P \
    -d '%Y/%m/%Y%m%d_%H%M%S' \
    '-filename<Organized/${FileModifyDate}_${SubSecTimeOriginal;}%-c.%le' \
    '-filename<Organized/${GPSDateTime}_${SubSecTimeOriginal;}%-c.%le' \
    '-filename<Organized/${MediaCreateDate}_${SubSecTimeOriginal;}%-c.%le' \
    '-filename<Organized/${ModifyDate}_${SubSecTimeOriginal;}%-c.%le' \
    '-filename<Organized/${DateTimeOriginal}_${SubSecTimeOriginal;}%-c.%le' \
    '-filename<Organized/${FileModifyDate}_000%-c.%le' \
    '-filename<Organized/${GPSDateTime}_000%-c.%le' \
    '-filename<Organized/${MediaCreateDate}_000%-c.%le' \
    '-filename<Organized/${ModifyDate}_000%-c.%le' \
    '-filename<Organized/${DateTimeOriginal}_000%-c.%le' \
    {}

