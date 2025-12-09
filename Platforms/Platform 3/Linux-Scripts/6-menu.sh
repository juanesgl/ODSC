#!/bin/bash

while true; do
  clear
  echo "=============================="
  echo "          MAIN MENU"
  echo "=============================="
  echo "1) Hello World"
  echo "2) Count lines in /etc/profile"
  echo "3) Search word in file"
  echo "4) Extract users from /etc/passwd"
  echo "5) Find files by permissions"
  echo "6) Exit"
  echo "=============================="
  read -r -p "Choose an option (1-6): " option

  case "$option" in
    1)
      ./1-hello.sh
      read -r -p "Press Enter to continue..." _
      ;;
    2)
      ./2-sequence.sh
      read -r -p "Press Enter to continue..." _
      ;;
    3)
      read -r -p "Enter word to search: " word
      read -r -p "Enter file path: " file
      ./3-search_word.sh "$word" "$file"
      read -r -p "Press Enter to continue..." _
      ;;
    4)
      ./4-extract_users.sh
      read -r -p "Press Enter to continue..." _
      ;;
    5)
      read -r -p "Enter directory: " dir
      read -r -p "Enter permission string (e.g. -rw-r--r--): " perms
      ./5-find_files.sh "$dir" "$perms"
      read -r -p "Press Enter to continue..." _
      ;;
    6)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid option."
      read -r -p "Press Enter to continue..." _
      ;;
  esac
done

