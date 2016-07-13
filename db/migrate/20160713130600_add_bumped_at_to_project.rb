class AddBumpedAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :bumped_at, :datetime
  end
end
