class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :project, foreign_key: true
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
