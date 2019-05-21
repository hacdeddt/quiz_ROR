class AddColumnsIsDelete < ActiveRecord::Migration[5.2]
  def change
  	add_column :subjects, :is_delete, :boolean, null: false, default: 0
    add_column :categories, :is_delete, :boolean, null: false, default: 0
  end
end
