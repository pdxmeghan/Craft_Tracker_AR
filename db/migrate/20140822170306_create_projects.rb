class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t. column :project_name, :string
      t. column :craft_type, :string

      t.timestamps
    end
  end
end
