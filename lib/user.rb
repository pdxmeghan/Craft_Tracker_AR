class User < ActiveRecord::Base
  has_and_belongs_to_many :projects
  validates :name, :presence => true
  before_save :capitalize_name

  scope :recently_added, -> { where(created_at > Date.today - 2).order(created_at: asc)}

private
  def capitalize_name
    self.name = self.name.split.map(&:capitalize).join(' ')
  end
end
