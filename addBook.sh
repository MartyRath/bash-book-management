# !/bin/bash
# Name: Marty Rath
# Student Number: 20104119
# Description: This script allows users to add in full details of new books to
# be added to the Book Catalogue.

# Creates file if it doesn't exist
touch bookCatalogue.txt

# Validates a year is numeric and less than current year
validateYear() {
  while true; do
    read -p "Year (or 'unknown'): " year
    # Ensures at least one digit, and only digits are in year, or if unknown is entered
    if [[ $year =~ ^[0-9]+$ && $year -le 2023 || $year == "unknown" ]]; then
      break
    else
      echo "Invalid year entered. Please enter a valid year (0-2023) or type 'unknown'."
      fi
    done
}

# Validates a phone number contains only digits
validatePhoneNumber() {
  while true; do
    read -p "Supplier phone number: " phoneNumber
    if [[ $phoneNumber =~ ^[0-9]+$ ]]; then
      break
    else
      echo "Invalid phone number. Please enter digits only."
    fi
  done
}

# Checks if email has an @ symbol and a dot
validateEmail() {
  while true; do
    read -p "Email address: " email
    # Checks email contains @ and .
    if [[ $email == *[@]* && $email == *[.]* ]]; then
      break
    else
      echo "Invalid email address. Please enter a valid email address."
      echo "e.g. example@mail.com"
    fi
  done
}

# Validates an ISBN to ensure it has 13 digits
validateISBN() {
  while true; do
    read -p "ISBN (13 digits): " isbn
    # Checks is ISBN is exactly 13 digits, and only digits
    if [[ $isbn =~ ^[0-9]{13}$ ]]; then
      break
    else
      echo -e "Invalid ISBN entered. You must enter 13 digits."
    fi
  done
}

# Checks if user input is blank and asks to enter a value if so
checkIfBlank() {
  if [[ -z $1 ]]; then
    echo "$2 cannot be blank. Please ensure each field has a value"
    return 1
  fi
}

# Check if entry is a duplicate by searching catalogue for entered title
checkIfDuplicate() {
  # grep checks if ISBN is already in catalogue
  if grep "$1" "bookCatalogue.txt"; then
    echo "The book with ISBN: $1 already exists in the catalogue"
    return 1
  fi
}

# Main function to add a book entry
addBookEntry() {
  echo "Add a new book"

  # Prompts user to enter value
  validateISBN

  # Checks if ISBN is already stored in catalogue
  checkIfDuplicate "$isbn" || return

  while true; do
    read -p "Title: " title
    # Check if input is blank and uses continue to restart loop if so
    checkIfBlank "$title" "Title" || continue

    read -p "Author: " author
    checkIfBlank "$author" "Author" || continue

    read -p "Genre: " genre
    checkIfBlank "$genre" "Genre" || continue

  # If all fields have values, breaks loop
    break
  done

    validateYear
    validatePhoneNumber
    validateEmail

    clear
    # Show entry
    echo "Book Entry"
    echo "Title: $title"
    echo "Author: $author"
    echo "Genre: $genre"
    echo "Year: $year"
    echo "Supplier Phone Number: $phoneNumber"
    echo "Supplier Email: $email"
    echo "ISBN: $isbn"

    # Ask for confirmation to add to catalogue
  while true; do
    read -p "Add book entry to catalogue (yes/no)? " choice

    case "$choice" in
        [Yy][Ee][Ss])
          # Store details and append to book catalogue
          bookEntry="$title,$author,$genre,$year,$phoneNumber,$email,$isbn"
	  echo "$bookEntry" >> "bookCatalogue.txt"
          echo "Book entry successfully added!"
	  break
	  ;;
	[Nn][Oo]) 
	  echo "Book entry not added."
	  break
          ;;
        *)
          echo "Invalid choice. Please enter 'yes' or 'no'."
          ;;
    esac
  done
}

# Main function
addBookEntry
