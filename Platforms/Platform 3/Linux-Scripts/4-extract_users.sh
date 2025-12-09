#!/bin/bash
clear

output_file="users_extraction.txt"

echo "Extracting usernames and descriptions from /etc/passwd..."
> "$output_file"


while IFS=':' read -r username _ _ _ description _; do
 
  [ -z "$username" ] && continue
  echo "$username: $description" >> "$output_file"
done < /etc/passwd

echo "Result saved to: $output_file"

