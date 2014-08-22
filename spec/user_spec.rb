require 'spec_helper'

describe User do
  it 'has many projects' do
    project = Project.create({project_name: 'zigzag scarf', craft_type: 'whatever'})
    user = User.create({name: 'meghan lindsley'})
    user.projects << project
    expect(user.projects).to eq [project]
  end

  it 'validates the presence of name' do
    user = User.create({name: ''})
    expect(user.save).to eq false
  end

  it 'capitalizes the name' do
    user = User.create({name: 'meghan lindsley'})
    expect(user.name).to eq 'Meghan Lindsley'
  end
end
