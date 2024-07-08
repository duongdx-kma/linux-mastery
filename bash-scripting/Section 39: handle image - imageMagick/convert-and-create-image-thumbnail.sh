#!/usr/bin/env bash

for filename in *.{jpg,png,gif}; do
    if [[ "${filename}" == *.thumbnail.* ]]; then
        continue
    fi

    if [[ ! -f "${filename}" ]]; then
        continue
    fi
    file_extension="${filename##*.}"
    filename_no_extension="${filename%.*}"
    thumbnail_filename="${filename_no_extension}.thumbnail.${file_extension}"

    # checking thumbnail
    if [[ -f "${thumbnail_filename}" ]]; then
        continue
    fi

    # get width, height of image:
    width=$(identify -format '%w' "${filename}")
    height=$(identify -format '%h' "${filename}")

    # create thumbnail when width or height > 100 px
    if (( width > 100 || height > 100 )); then
        convert "${filename}" -resize 100x100 "${thumbnail_filename}"
    fi
done