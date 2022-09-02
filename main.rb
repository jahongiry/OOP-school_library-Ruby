require_relative 'app'

class Main
  def initialize
    @app = App.new
  end

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

  def execute_option(option)
    case option
    when 1
      @app.list_all_books
    when 2
      @app.list_all_people
    when 3
      @app.create_person
    when 4
      @app.create_book
    when 5
      @app.create_rental
    when 6
      @app.display_rentals_by_person_id
    else
      puts 'Not a valid option'
    end
  end

  def choose_option
    loop do
      display_list
      option = gets.chomp.to_i
      break if option == 7

      execute_option(option)
    end
  end

  def main
    puts 'Welcome to School library app!'
    choose_option
    puts 'Thank you for using School library app!'
  end
end

main = Main.new
main.main
