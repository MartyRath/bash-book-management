# !/bin/bash
# Name: Marty Rath
# Student Number: 20104119
# Description: Remove book records from the catalogue.

# Formats bookCatalgoue with more readable spacing
formattedCatalogue() {
  awk -F',' '{ printf "%-30s %-15s %-20s %-6s %-12s %-25s %-13s\n", $1, $2, $3, $4, $5, $6, $7 }' bookCatalogue.txt
}

addHeadings() {
  awk -F',' '{ printf "%-30s %-15s %-20s %-6s %-12s %-25s %-13s\n", $1, $2, $3, $4, $5, $6, $7 }' headings.txt
}

continuePrompt() {
  read -p "Press any key to continue..."
  clear
}

# Main loop to search for book(s) to remove
while true; do
  echo "Remove books"
  read -p "Enter a keyword to search for books in the catalogue (or enter to exit): " keyword

  # Exits loop if user presses enter. -z checks for zero input
  if [ -z "$keyword" ]; then
    break
  fi

  # Aligns the headings with the results by adding two spaces
  echo -n "  " && addHeadings
  # Finds and prints results from keyword
  formattedCatalogue | grep -i -E "$keyword" | awk '{print NR, $0}'
  echo

  # Prompt the user for the lines they want to delete separated by commas
  echo "1. Delete all results from catalogue"
  echo "2. Specify line number(s) to delete (e.g. 1,4,5)"
  echo "3. Return to search"
  read -p "Selection: " choice

  # Use a case statement to process the user's choice
  case $choice in
    1)
      read -p "Are you sure you want to delete all books matching '$keyword'? (yes/no): " confirm
      if [ "$confirm" == "yes" ]; then
        # Using sed /d to delete all lines that match the pattern, and the -i option
        # to save the changes rather than display them. I ensures it is case insensitive
        sed -i "/$keyword/I d" bookCatalogue.txt
        echo "All books matching '$keyword' have been removed from the catalogue."
	continuePrompt
      else
        echo "No books were deleted."
	continuePrompt
      fi
      ;;
    2)
      # Handle the case where the user wants to specify line number(s) to delete
      # Call a script or function to handle this action
      ./removeSpecificLines.sh
      continuePrompt
      ;;
    3)
      # Handle the case where the user wants to go back
      continue
      ;;
    *)
      echo "Invalid selection. Please enter a valid option (1-3)."
      ;;
  esac
done
