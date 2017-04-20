#!/usr/bin/env bash

# see: http://askubuntu.com/questions/214018/how-to-make-wget-faster-or-multithreading

filename="$1" # get filename from command line argument

while read -r line; do
    # skip blank lines
    if [[ "${line}" ]] && [[ ! "${line}" =~ ^\s*# ]]; then
        if [[ "${line}" =~ (https?|ftp)\:\/\/ ]]; then
            # line contains a URL, download file
            echo "URL: '${line}' current_dir: '${current_dir}'"
            aria2c --file-allocation=none -c -x 10 -s 10 -m 0 --console-log-level=notice --log-level=notice --summary-interval=0 -d "${current_dir}" "${line}"
        else
            # line contains a directory name, create directory if not already present
            echo "Directory: '${line}'"
            current_dir="${line}"
            if [ ! -d "${current_dir}" ]; then
                mkdir -p "{$current_dir}"
            fi
        fi
    fi
done < "${filename}"
