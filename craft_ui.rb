require 'bundler/setup'
Bundler.require(:default, :test)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def whitespace
  puts "\n\n"
end

def header
  system 'clear'
end

def main_menu
  whitespace
  menu_input = nil
  until menu_input == 'x'
    puts "[1] - to add a user"
    puts "[2] - to list all users"
    puts "[3] - to add a project"
    puts "[4] - to list all projects"
    puts "[x] - to exit the program"
    menu_input = gets.chomp
    case menu_input
    when '1'
      add_user
    when '2'
      list_users
    when '3'
      add_project
    when '4'
      list_projects
    when 'x'
      puts "goodbye!"
      exit
    else
      puts "Sorry! That wasn't a valid option. Pick again."
    end
  end
end

def add_user
  header
  puts "What is the name of the new user?"
  new_user = User.create({name: gets.chomp})
  whitespace
  puts "Thanks! #{new_user.name} has been added to the user database"
end

def list_users
  header
  puts "Here are all of the users in the database:"
  User.all.each { |user| puts "#{user.id} | #{user.name}" }
end


main_menu
