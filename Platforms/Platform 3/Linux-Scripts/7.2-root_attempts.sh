#!/bin/bash
clear

echo "Checking illegal access attempts to user root (Arch Linux, journalctl)..."
echo "==============================================="


entries=$(journalctl -q _UID=0 --no-pager | grep -Ei "failed|authentication failure|incorrect password")

if [ -z "$entries" ]; then
  echo "No failed attempts to root found."
  exit 0
fi

count=0
while IFS= read -r line; do
  echo "$line"
  count=$((count + 1))
done <<< "$entries"

echo "==============================================="
echo "Total failed attempts to root: $count"
echo "==============================================="

