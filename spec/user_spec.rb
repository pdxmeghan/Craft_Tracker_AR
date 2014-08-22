require 'spec_helper'

describe User do
  # it { should have_and_belong_to_many :projects }
  # it 'has many projects'

  it 'validates the presence of name' do
    user = User.create({name: ''})
    expect(user.save).to eq false
  end

  it 'capitalizes the name' do
    user = User.create({name: 'meghan lindsley'})
    expect(user.name).to eq 'Meghan Lindsley'
  end
end
