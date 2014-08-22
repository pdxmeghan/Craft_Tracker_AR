require 'spec_helper'

describe Project do
  it 'will validate the presence of name' do
    project = Project.create({project_name: ''})
    expect(project.save).to eq false
  end

  it 'will capitalize all of the name before saving' do
    project = Project.create({project_name: 'zigzag scarf'})
    expect(project.project_name).to eq 'Zigzag Scarf'
  end
end
