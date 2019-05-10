class AddFullnameIndexToUser < ActiveRecord::Migration[5.2]
  def change
  	add_index :users, :fullName
  	add_index :subjects, :name, unique: true
  	add_index :categories, :name, unique: true
  end
end
