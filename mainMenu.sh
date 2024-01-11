# !/bin/bash
# Author: Marty Rath
# Student Number: 20104119
# Description: This is the main menu for the Book Catalogue Management System. 
# It gives options for how the user can interact with the catalogue of books with supplier
# contact details.

# Function to prompt user to continue
continuePrompt() {
  read -p "Press enter to continue..."
}

header() {
  clear
  echo "--------------------------------"
  echo "Book Catalogue Management System"
  echo "--------------------------------"
}

displayWelcomeMessage() {
  clear
  echo "--------------------------------------------------------"
  echo "Welcome $USER to the Book Catalogue Management System!"
  echo "--------------------------------------------------------"
  echo "This system allows you to interact with the Book Catalogue Management System"
  echo "to store book and supplier details."
  continuePrompt
}

displayMainMenu() {
  clear
  echo "Book Catalogue Management System: Main Menu"
  echo "1. Add a new book"
  echo "2. Search for books"
  echo "3. Remove a book"
  echo "4. Generate reports"
  echo "5. Exit"
}

displayWelcomeMessage

# Loop showing users main menu and options
while true; do
  displayMainMenu
  read -p "Select an option (1-5): " choice 
    case $choice in
	1)
	  header
	  ./addBook.sh
	  continuePrompt
	;;
	2)
	  header
	  echo "Search for books"
	  ./searchBooks.sh
	  continuePrompt
	;;
	3)
	  header
	  ./removeBooks.sh
	  continuePrompt
	;;
	4)
	  header
	  ./generateReport.sh
	  continuePrompt
	;;
	5)
  	  echo "Exiting program..." 
	exit 0
	;;
	*)
	  echo "Invalid option. Please choose an option (1-5)." 
    	  continuePrompt
	  ;;
    esac
done
