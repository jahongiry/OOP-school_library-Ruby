module Options
  def display_list
      puts "
        Please choose an option by entering a number:
        1- List all books.
        2- List all people.
        3- Create a person (teacher or student, not a plain Person).
        4- Create a book.
        5- Create a rental.
        6- List all rentals for a given person id.
        7- Exit"
  end
end