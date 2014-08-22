class User < ActiveRecord::Base
  validates :name, :presence => true

  before_save :capitalize_name

private
  def capitalize_name
    self.name = self.name.split.map(&:capitalize).join(' ')
  end
end
