# requires exiftool

find unprocessed -type f -print0 | xargs -0 -I {} exiftool -P \
    -d '%Y/%m/%d/%Y%m%d_%H%M%S' \
    '-filename<organized/${FileModifyDate}_${SubSecTimeOriginal;}%-c.%le' \
    '-filename<organized/${GPSDateTime}_${SubSecTimeOriginal;}%-c.%le' \
    '-filename<organized/${MediaCreateDate}_${SubSecTimeOriginal;}%-c.%le' \
    '-filename<organized/${ModifyDate}_${SubSecTimeOriginal;}%-c.%le' \
    '-filename<organized/${DateTimeOriginal}_${SubSecTimeOriginal;}%-c.%le' \
    '-filename<organized/${FileModifyDate}_000%-c.%le' \
    '-filename<organized/${GPSDateTime}_000%-c.%le' \
    '-filename<organized/${MediaCreateDate}_000%-c.%le' \
    '-filename<organized/${ModifyDate}_000%-c.%le' \
    '-filename<organized/${DateTimeOriginal}_000%-c.%le' \
    {}

