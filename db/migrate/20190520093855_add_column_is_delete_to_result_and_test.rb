class AddColumnIsDeleteToResultAndTest < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :is_delete, :boolean, null: false, default: 0
    add_column :results, :is_delete, :boolean, null: false, default: 0
  end
end
