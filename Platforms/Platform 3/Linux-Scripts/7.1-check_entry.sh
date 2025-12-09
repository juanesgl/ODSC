#!/bin/bash
clear

# Validate arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 name directory"
  echo "Example: $0 poem.txt /home/user/Documents"
  exit 1
fi

name=$1
dir=$2
path="$dir/$name"


if [ ! -d "$dir" ]; then
  echo "Error: '$dir' is not a valid directory."
  exit 1
fi

echo "Checking '$name' inside '$dir'..."

if [ -e "$path" ]; then
  if [ -f "$path" ]; then
    echo "'$name' is a regular FILE."
  elif [ -d "$path" ]; then
    echo "'$name' is a SUBDIRECTORY."
  else
    echo "'$name' is SOMETHING ELSE (link, device, socket, etc.)."
  fi
else
  echo "'$name' does not exist in that directory."
fi

