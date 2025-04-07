#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

dir="$1"

if [[ ! -d "$dir" ]]; then
    echo "Error: '$dir' is not a directory!"
    exit 1
fi

echo "Sorting files in '$dir' by size:"
find "$dir" -type f -exec du -b {} + | sort -n | awk '{print $2, "(" $1 " bytes)"}'
