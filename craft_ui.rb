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
    puts "[5] - to add a project to a user"
    puts "[6] - to list all of a user's projects"
    puts "[7] - to list all of a project's users"
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
    when '5'
      add_project_to_user
    when '6'
      one_users_projects
    when '7'
      one_projects_users
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

def add_project
  header
  puts "What is the name of the new project?\n"
  project_name = gets.chomp
  puts "What type of craft is it?"
  craft_type = gets.chomp
  new_project = Project.create({project_name: project_name, craft_type: craft_type})
  puts "Thanks! #{new_project.project_name} has been added to the user database"
end

def list_projects
  header
  puts "Here are all of the projects in the database"
  Project.all.each { |project| puts "#{project.id} | #{project.project_name} | #{project.craft_type}" }
end

def add_project_to_user
  list_users
  puts "Enter the index # of the user you would like to select"
  user_choice = gets.chomp
  chosen_user = User.find_by(id: user_choice)
  whitespace
  list_projects
  puts "Enter the index # of the project you would like to select"
  project_choice = gets.chomp
  chosen_project = Project.find_by(id: project_choice)
  chosen_project.users << chosen_user
  puts "Thanks! You have chosen to add #{chosen_project.project_name} to #{chosen_user.name}'s list of projects."
end

main_menu
