class AddTrelloToProject < ActiveRecord::Migration
  def change
    add_column :projects, :trello, :string
  end
end
