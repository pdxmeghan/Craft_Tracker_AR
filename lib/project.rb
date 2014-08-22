class Project < ActiveRecord::Base
  validates :project_name, :presence => true
  before_save :capitalize_project_name


private
  def capitalize_project_name
    self.project_name = self.project_name.split.map(&:capitalize).join(' ')
  end
end
