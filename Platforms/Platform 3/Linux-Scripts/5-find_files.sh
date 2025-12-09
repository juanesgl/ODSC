#!/bin/bash
clear


if [ "$#" -ne 2 ]; then
  echo "Usage: $0 directory permission_string"
  echo "Example: $0 /etc/ -rw-r--r--"
  exit 1
fi

dir=$1
perm_string=$2


if [ ! -d "$dir" ]; then
  echo "Error: '$dir' is not a valid directory."
  exit 1
fi

echo "Searching in '$dir' for files with permissions '$perm_string'..."


perm_numeric=$(stat -c '%a' /dev/null 2>/dev/null)

find "$dir" -maxdepth 1 -type f -printf '%M %p\n' | awk -v p="$perm_string" '$1 == p'

