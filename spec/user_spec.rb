require 'spec_helper'

describe User do
  it 'validates the presence of name' do
    user = User.new({name: ''})
    expect(user.save).to eq false
  end

  it 'capitalizes the name' do
    user = User.create({name: 'meghan'})
    expect(user.name).to eq 'Meghan'
  end
end
