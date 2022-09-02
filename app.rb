require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'classroom'

class App
  attr_accessor :books, :people, :rentals, :classroom

  def initialize
    @books = []
    @people = []
    @rentals = []
    @classroom = Classroom.new('Computer Science')
  end

  def list_all_books
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people
    people.each do |person|
      puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teache (2)? [Input a number]:'
    person_type = gets.chomp.to_i

    case person_type
    when 1
      create_student
    when 2
      create_teacher
    else
      invalid_input
    end
  end

  def create_student
    puts 'Age:'
    age = gets.chomp.to_i
    puts 'Name:'
    name = gets.chomp.to_s
    puts 'Has parent permission? [Y/N]:'
    case gets.chomp.capitalize
    when 'Y'
      permission = true
    when 'N'
      permission = false
    else
      return invalid_input
    end

    people.push(Student.new(age, classroom, name, parent_permission: permission))
    puts 'Person created successfully'
  end

  def create_teacher
    puts 'Age:'
    age = gets.chomp.to_i
    puts 'Name:'
    name = gets.chomp.to_s
    puts 'Specialization:'
    specialization = gets.chomp.to_s

    people.push(Teacher.new(age, specialization, name))
    puts 'Person created successfully'
  end

  def create_book
    puts 'Title:'
    title = gets.chomp.to_s
    puts 'Author:'
    author = gets.chomp.to_s

    books.push(Book.new(title, author))
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number: '
    books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title} Author: #{book.author}"
    end
    book_index = gets.chomp.to_i
    return invalid_input if book_index > books.length

    puts 'Select a person from the following list by number (not id): '
    people.each_with_index do |person, index|
      puts "#{index}) [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i
    return invalid_input if person_index > people.length

    print 'Date: '
    date = gets.chomp.to_s

    rentals.push(Rental.new(date, people[person_index], books[book_index]))
    puts 'Rental created successfully.'
  end

  def display_rentals_by_person_id
    print 'Person ID: '
    person_id = gets.chomp.to_i
    rentals.each do |rent|
      puts "Date: #{rent.date}, Book: #{rent.book.title} by #{rent.book.author}." if rent.person.id == person_id
    end
  end

  def invalid_input
    puts 'Invalid Input'
  end
end
