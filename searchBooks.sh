#!/bin/bash
# Name: Marty Rath
# Student Number: 20104119
# Description: Search book records within the catalogue.

# Formats bookCatalogue.txt with appopriate spacing for reading.
formattedCatalogue() {
  awk -F',' '{ printf "%-30s %-15s %-20s %-6s %-12s %-25s %-13s\n", $1, $2, $3, $4, $5, $6, $7 }'
}

# Adds heading formatted as above
addHeadings() {
awk -F',' '{ printf "%-30s %-15s %-20s %-6s %-12s %-25s %-13s\n", $1, $2, $3, $4, $5, $6, $7 }' headings.txt
}

# Main loop for search
while true; do
  read -p "Enter a keyword to search (or press Enter to exit): " keyWord

  # Breaks loop if keyword is empty
  if [ -z "$keyWord" ]; then
    break
  fi

  # Using grep to search insensitive, ignoring special characters. Then, piping to format function.
  searchResults=$(grep -i -F "$keyWord" bookCatalogue.txt | formattedCatalogue)

  # Counts result lines and stores as variable
  resultCount=$(echo "$searchResults" | wc -l)

  # -n checks if string is not empty
  if [ -n "$searchResults" ]; then
    clear
    echo "There are '$resultCount' results for '$keyWord'"
    # Add spaces without newline to better align headings
    echo -n "  " && addHeadings
    # Prints formatted results based on keyword
    formattedCatalogue < bookCatalogue.txt | grep -i -F "$keyWord" | awk '{print NR, $0}'
    else
    echo "No results found for '$keyWord'."
  fi
done
