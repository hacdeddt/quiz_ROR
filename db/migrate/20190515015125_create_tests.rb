class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :name, null: false
      t.text :description
      t.integer :full_score, null: false
      t.integer :duration, null: false
      t.integer :views, default: 0
      t.integer :category_id
      t.integer :subject_id
      t.integer :user_id

      t.timestamps
    end
    add_index :tests, [:name, :description], name: "search_test", type: :fulltext
    add_index :tests, :name, unique: true
    add_index :tests, :category_id
    add_index :tests, :user_id
    add_index :tests, :subject_id
  end
end
