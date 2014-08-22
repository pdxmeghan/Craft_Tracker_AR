class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :project_name, :presence => true
  validates :craft_type, :presence => true
  before_save :capitalize_project_name
  before_save :capitalize_craft_type

  scope :recently_added, -> { where('created_at >= ?', Date.today - 2).order(created_at: :asc)}

private
  def capitalize_project_name
    self.project_name = self.project_name.split.map(&:capitalize).join(' ')
  end

  def capitalize_craft_type
    self.craft_type = self.craft_type.split.map(&:capitalize).join(' ')
  end
end
