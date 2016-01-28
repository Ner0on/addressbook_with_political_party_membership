class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      
      t.string  :name
      t.string  :last_name
      t.string  :phone
      t.string  :email
      t.string  :id_number
      t.belongs_to :addressbook

      t.timestamps null: false
    end
  end
end
