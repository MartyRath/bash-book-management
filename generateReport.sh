# !/bin/bash
# Name: Marty Rath
# Student Number: 20104119
# Description: Allows user to generate reports such as viewing all books, newly added books, newest
# published books and search for books.

# Prints user-friendly catalogue with spacing between columns
formattedCatalogue() {
  awk -F',' '{ printf "%-30s %-15s %-20s %-6s %-12s %-25s %-13s\n", $1, $2, $3, $4, $5, $6, $7 }'
}

continuePrompt() {
  read -p "Press enter to continue..."
}

# Main loop for script
while true; do
  echo "Generate Reports"
  echo "1. All books in catalogue"
  echo "2. New arrivals in catalogue"
  echo "3. Newest published books"
  echo "4. Search for specific books by title, author, genre"
  echo "5. Back to Main Menu"
  read -p "Selection (1-5): " reportChoice

  case $reportChoice in
    1)
      clear
      echo "All books in catalogue. Total: " `wc -l < bookCatalogue.txt`
      formattedCatalogue < headings.txt
      formattedCatalogue < bookCatalogue.txt
      continuePrompt
    ;;
    2)
      clear
      echo "Newest arrivals in catalogue"
      formattedCatalogue < headings.txt
      formattedCatalogue < bookCatalogue.txt | tail -n 5
      continuePrompt
    ;;
    3)
      clear
      echo "Newest published books"
      formattedCatalogue < headings.txt
      # Sort comma delimited catalogue by fourth column in reverse numeric order
      sort -t',' -k4,4rn bookCatalogue.txt | formattedCatalogue | head -n 5
      continuePrompt
    ;;
    4)
      ./searchBooks.sh
      continuePrompt
    ;;
    5)
      # Return to the main menu
      break
    ;;
    *)
    echo "Invalid selection. Please enter a valid option (1-4)."
    ;;
  esac
done
