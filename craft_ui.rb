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
  menu_input = nil
  until menu_input == 'x'
    whitespace
    puts "[1] - to add a user"
    puts "[2] - to list all users"
    puts "[3] - to add a project"
    puts "[4] - to list all projects"
    puts "[5] - to add a project to a user"
    puts "[6] - to list all of a user's projects"
    puts "[7] - to list all of a project's users"
    puts "[8] - to view recently added projects"
    puts "[9] - to view recently added users"
    puts "[10] - to edit a user"
    puts "[11] - to edit a project"
    puts "[12] - to delete a user"
    puts "[13] - to delete a project"
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
    when '8'
      recently_added_projects
    when '9'
      recently_added_users
    when '10'
      edit_user
    when '11'
      edit_project
    when '12'
      delete_user
    when '13'
      delete_project
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

def one_users_projects
  header
  list_users
  puts "Enter the index # of the user whose projects you would like to see"
  chosen_user = User.find_by(id: gets.chomp)
  puts "\n\n#{chosen_user.name}'s projects are:"
  chosen_user.projects.each do |project|
    puts "#{project.project_name} | #{project.craft_type}"
  end
end

def one_projects_users
  header
  list_projects
  puts "Enter the index #  of the project whose users you would like to see"
  chosen_project = Project.find_by(id: gets.chomp)
  puts "\n\n#{chosen_project.project_name}'s users are:"
  chosen_project.users.each do |user|
    puts "#{user.id} | #{user.name}"
  end
end

def recently_added_projects
  header
  Project.recently_added.each do |project|
    puts "#{project.project_name} | #{project.craft_type}"
  end
end

def recently_added_users
  header
  User.recently_added.each do |user|
    puts "#{user.id} | #{user.name}"
  end
end

def edit_user
  header
  list_users
  puts "Enter the index # of the user you would like to edit"
  chosen_user = User.find_by(id: gets.chomp)
  whitespace
  puts "Please enter what you would like the user's name to be"
  whitespace
  chosen_user.update(name: gets.chomp)
  puts "Thanks! This user's name will read as: #{chosen_user.name}"
end

def edit_project
  header
  list_projects
  puts "Enter the index # of the project you would like to edit"
  chosen_project = Project.find_by(id: gets.chomp)
  whitespace
  puts "Please enter what you would like the projects's name to be"
  project_name = gets.chomp
  whitespace
  puts "Please enter what you would like the craft type to be"
  craft_type = gets.chomp
  chosen_project.update(project_name: project_name, craft_type: craft_type)
  puts "Thanks! This project's name will read as: #{chosen_project.project_name}, and the craft type will be #{chosen_project.craft_type}"
end

def delete_user
  header
  list_users
  puts "Enter the index # of the user you would like to delete"
  deleted = User.find_by(id: gets.chomp)
  deleted.destroy
  puts "#{deleted.name} has been deleted"
end

def delete_project
  header
  list_projects
  puts "Enter the index # of the project you would like to delete"
  deleted = Project.find_by(id: gets.chomp)
  deleted.destroy
  puts "#{deleted.project_name} has been deleted"
end

main_menu
