# !/bin/bash
# Author: Marty Rath
# Student Number: 20104119
# Description: This script searches the catalogue and
#   allows the user to delete lines by specifying their line number.

# Formats bookCatalogue with more user-friendly output
formattedCatalogue() {
  awk -F',' '{ printf "%-30s %-15s %-20s %-6s %-12s %-25s %-13s\n", $1, $2, $3, $4, $5, $6, $7 }'
}

read -p "Enter line number(s) to delete (e.g. 1,4,5): " linesToDelete

# Create a temporary file to store the selected lines
tempFile=$(mktemp)
touch "$tempFile"

# For each lineNum in lineToDelete... and translate , to a space
for lineNum in $(echo "$linesToDelete" | tr ',' ' '); do
  # The lines specified to delete by the user are copied to the tempFile
  # with sed: -n to stop it copying all lines, : p to copy only lines
  # specified
  sed -n "${lineNum}p" bookCatalogue.txt >> "$tempFile"
done

# Print lines for deletion
echo "You have selected the following lines for deletion:" 
formattedCatalogue < $tempFile

# Ask the user for confirmation
read -p "Are you sure you want to delete the above lines? (yes/no): " confirm
if [ "$confirm" == "yes" ]; then
  # Use grep to invert search the patterns in tempFile in bookCatalogue, then
  # save the results to tempCatalogue.txt
  grep -v -f "$tempFile" bookCatalogue.txt > tempCatalogue.txt

  # Overwrite the original bookCatalogue.txt with the updated file
  mv tempCatalogue.txt bookCatalogue.txt

  echo "Selected lines have been deleted."
else
  echo "No lines were deleted."
fi

# Remove the temp file
rm -f "$tempFile"
