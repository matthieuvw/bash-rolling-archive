#!/bin/bash

if [[ $# -ne 2 ]] ; then
    echo "wrong usage : $0 <dir-source> <dir-dest>"
    exit 1
fi

if [ -d "$1" ]; then
    echo "rolling-archive directory $1 ..."
fi

[ -d "$1" ] || mkdir -p "$2"

source_path=$(realpath $1)
dest_path=$(realpath $2)

file_prefix="rolling-archive"
file_extension="tar.gz"

temp_archive="$dest_path/temp_archive.tar.gz"

[ -f "$temp_archive" ] && rm $temp_archive
tar -czvf "$temp_archive" -C $source_path $source_path

archive_and_delete_old_files() {
    local file_path="$dest_path/$(echo $file_prefix)_$1_$(date "$2").$file_extension"
    [ -f "$file_path" ] || cp $temp_archive $file_path
    [ -f "/tmp/$1_limit" ] && rm -f "/tmp/$1_limit"
    touch -t $(date --date "$3" "+%Y%m%d%H%M") "/tmp/$1_limit"
    find "$dest_path" ! -newer "/tmp/$1_limit" -name "*$1*" -delete
    [ -f "/tmp/$1_limit" ] && rm -f "/tmp/$1_limit"
}

archive_and_delete_old_files "hourly" "+%Y%m%d_%H" "-24 hours"
archive_and_delete_old_files "daily" "+%Y%m%d" "-7 days"
archive_and_delete_old_files "weekly" "+%Y_%U" "-5 weeks"
archive_and_delete_old_files "monthly" "+%m" "-6 months"
archive_and_delete_old_files "yearly" "+%Y" "-2 years"

rm $temp_archive
