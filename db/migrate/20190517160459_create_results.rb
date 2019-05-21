class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.float :total_time
      t.float :total_score, default: 0
      t.integer :test_id
      t.integer :user_id

      t.timestamps
    end
    add_index :results, :test_id
    add_index :results, :user_id
  end
end
