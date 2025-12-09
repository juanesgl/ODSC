#!/bin/bash
clear


if [ "$#" -ne 2 ]; then
  echo "Usage: $0 word file"
  echo "Example: $0 house /etc/passwd"
  exit 1
fi

word=$1
file=$2


if [ ! -f "$file" ]; then
  echo "The file '$file' does not exist."
  exit 1
fi

echo "Searching for '$word' in '$file':"
grep -n -- "$word" "$file"
