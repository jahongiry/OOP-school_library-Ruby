require_relative './book'
require_relative './student'
require_relative '.teacher'
require_relative './rental'

class App
  def initialize
    @books = []
    @people = []
  end

  def print_by_class_attr(array)
    str = "\n"
    array.each_with_index do |instance, index|
      str << "#{index + 1}) [#{instance.class}] "
      instance.instance_variables.map do |vars|
        name = vars.to_s.delete('@').capitalize.gsub('_', ' ')
        instance_var = instance.instance_variable_get(vars)
        str << "#{name}: '#{instance_var}' " unless instance_var.is_a?(Array)
      end
      str << "\n------- \n"
    end
    str
  end

  def list_books(**args)
    go_back_or_exit if @books.empty?
    print print_by_class_attr(@books)
    go_back_or_exit unless args[:exit] == false
  end

  def list_people(**args)
    go_back_or_exit if @people.empty?
    print print_by_class_attr(@people)
    go_back_or_exit unless args[:exit] == false
  end

  def create_student(**args)
    @people << Student.new(
      age: args[:age],
      name: args[:name],
      parent_permission: args[:parent_permission]
    )

    puts 'New Student added'
    run
  end

  def create_teacher(**args)
    @people << Teacher.new(
      specialization: args[:specialization],
      age: args[:age],
      name: args[:name],
      parent_permission: args[:parent_permission]
    )
    puts 'New Teacher added'
    run
  end

  def create_book(title, author)
    @books << Book.new(title, author)
    puts 'Book added'
    sleep 1
    run
  end

  def create_rental(**args)
    person = @people[args[:person]]
    if person.parent_permission == false
      printf "This person does not have permission to rent a book\n"
      return run
    end

    Rental.new(args[:date], @books[args[:book]], @people[args[:person]])
    puts 'New rental created!'
    run
  end

  def list_all_rentals(id)
    person = @people.select { |man| man.id == id }
    return "No rentals for the person with id: #{id}" if person.length.zero?

    person[0].rentals.each do |book|
      printf "Date: #{book.date}, "
      printf "Title: \"#{book.book.title}\" "
      printf "by #{book.book.author}\n"
    end

    run
  end

  def go_back_or_exit
    puts "1) Go back\n"
    puts "\e[41m2)\e[0m Exit app\n"
    opti = gets.chomp.to_i
    case opti
    when 1
      run
    when 2
      exit!
    else
      puts 'wrong!'
      run
    end
  end
end
