require 'spec_helper'

describe Project do

  it 'has many users' do
    project = Project.create({project_name: 'zigzag scarf', craft_type: 'whatever'})
    user = User.create({name: 'meghan lindsley'})
    project.users << user
    expect(project.users).to eq [user]
  end

  it 'will validate the presence of name' do
    project = Project.create({project_name: ''})
    expect(project.save).to eq false
  end

  it 'will capitalize all of the name before saving' do
    project = Project.create({project_name: 'zigzag scarf', craft_type: 'whatever'})
    expect(project.project_name).to eq 'Zigzag Scarf'
  end

  it 'will validate the presence of craft type' do
    project = Project.create({project_name: 'Zigzag Scarf', craft_type: ''})
    expect(project.save).to eq false
  end

  it 'will capitalize the craft type before saving' do
    project = Project.create({project_name: 'Zigzag Scarf', craft_type: 'crochet khook'})
    expect(project.craft_type).to eq 'Crochet Khook'
  end
end
