class CreateContactMails < ActiveRecord::Migration
  def change
    create_table :contact_mails do |t|
      t.string :email
      t.string :name
      t.text :text

      t.timestamps null: false
    end
  end
end
