class AddSlackToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :slack, :string
  end
end
