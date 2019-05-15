class CreateTestQbanks < ActiveRecord::Migration[5.2]
  def change
    create_table :test_qbanks do |t|
      t.integer :qbank_id
      t.integer :test_id

      t.timestamps
    end
    add_index :test_qbanks, :qbank_id
    add_index :test_qbanks, :test_id
  end
end
