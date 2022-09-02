#!/usr/bin/env ruby

require_relative 'app'

class Main < App
  WRONG_OPTION = 'Wrong Option'.freeze
  def menu_create_person_type
    puts <<~MENU
      ########################
      1) Student
      2) Teacher
      ########################
    MENU
    printf 'Choose an option = '
    opti = gets.chomp.to_i

    case opti
    when 1
      menu_create_person('Student')
    when 2
      menu_create_person('Teacher')
    else
      puts WRONG_OPTION
      run
    end
  end

  def check_permissions(age)
    age_num = age.to_i
    return true if age_num >= 18

    printf "\nHas parent permissions? (Y/N) = "
    answer = gets.chomp.downcase

    answer == 'y' || answer.empty?
  end

  def menu_create_person(type)
    printf 'Age* = '
    age = gets.chomp
    if type == 'Teacher'
      printf "\nSpecjalization* = "
      specialization = gets.chomp
    end
    printf "\nName = "
    name = gets.chomp
    age.empty? && run
    permissions = check_permissions(age)
    case type
    when 'Teacher'
      specialization.empty? && run
      create_teacher(specialization:, age:, name:, parent_permission: permissions)
    when 'Student'
      create_student(age:, name:, parent_permission: permissions)
    else
      go_back_or_exit
    end
  end

  def menu_create_book
    puts "\nAdd book:\n\n"
    printf 'Title = '
    title = gets.chomp
    printf "\nAuthor = "
    author = gets.chomp

    (title.empty? || author.empty?) && run

    create_book(title, author)
  end

  def run
    puts <<~MENU
      ########################
      1) List all books
      2) List all people
      3) Create a person
      4) Create a book
      5) Create a rental
      6) List all rentals for a person
      7) Exit
      ########################
    MENU
    printf 'Choose an option = '
    opti = gets.chomp.to_i
    run_start_options(opti)
  end

  def menu_create_rental
    list_people(exit: false)
    printf "\nChoose a person by index number = "
    person_index = gets.chomp.to_i - 1

    list_books(exit: false)
    printf "\nChoose a book by index number = "
    book_index = gets.chomp.to_i - 1

    printf "\nRental Date = "
    date = gets.chomp

    (date == '' || person_index == -1 || book_index == -1) && run
    create_rental(date:, book: book_index, person: person_index)
  end

  def menu_list_rentals
    printf "\nPerson ID = "

    id = gets.chomp.to_i
    list_all_rentals(id)
  end

  def run_start_options(opti)
    case opti
    when 1
      list_books
    when 2
      list_people
    when 3
      menu_create_person_type
    when 4
      menu_create_book
    when 5
      menu_create_rental
    when 6
      menu_list_rentals
    else
      puts 'Exiting...'
      exit!
    end
  end
end

Main.new.run
