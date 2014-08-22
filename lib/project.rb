class Project < ActiveRecord::Base
  validates :project_name, :presence => true
  validates :craft_type, :presence => true
  before_save :capitalize_project_name
  before_save :capitalize_craft_type


private
  def capitalize_project_name
    self.project_name = self.project_name.split.map(&:capitalize).join(' ')
  end

  def capitalize_craft_type
    self.craft_type = self.craft_type.split.map(&:capitalize).join(' ')
  end
end
