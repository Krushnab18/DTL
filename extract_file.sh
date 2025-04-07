#!/bin/bash

extract() {
    file="$1"

    if [[ ! -f "$file" ]]; then
        echo "Error: File '$file' does not exist!"
        return 1
    fi

    dir="${file%.*}"
    mkdir -p "$dirname"

    case "$file" in
    *.tar.bz2)
        tar xvjf "$file" -C "$dir"
        ;;
    *.tar.gz)
        tar xvzf "$file" -C "$dir"
        ;;
    *.tar.xz)
        tar xvJf "$file" -C "$dir"
        ;;
    *.tar.Z)
        tar xvZf "$file" -C "$dir"
        ;;
    *.tar)
        tar xvf "$file" -C "$dir"
        ;;
    *.bz2)
        bzip2 -dk "$file" && mv "${file%.bz2}" "$dir/"
        ;;
    *.gz)
        gunzip -c "$file" >"$dir/${file%.gz}"
        ;;
    *.zip)
        unzip "$file" -d "$dir"
        ;;
    *.rar)
        unrar x "$file" "$dir/"
        ;;
    *.7z)
        7z x "$file" -o"$dir"
        ;;
    *.Z)
        uncompress -c "$file" >"$dir/${file%.Z}"
        ;;
    *)
        echo "Error: Unknown file format '$file'"
        return 1
        ;;
    esac

    echo "Extracted file in directory: $dirname"
}

if [[ $# -eq 0 ]]; then
    echo "Use: $0 <file-to-extract>"
    exit 1
fi

extract "$1"
