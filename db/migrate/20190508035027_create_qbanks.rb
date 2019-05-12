class CreateQbanks < ActiveRecord::Migration[5.2]
  def change
    create_table :qbanks do |t|
      t.text :question, null: false
      t.text :optionA, null: false
      t.text :optionB, null: false
      t.text :optionC, null: false
      t.text :optionD, null: false
      t.string :option_match, null: false
      t.text :answer
      t.string :image
      t.string :mp3
      t.boolean :accept, null: false, default: 0
      t.string :md5_question
      t.boolean :is_delete, null: false, default: 0
      t.integer :category_id
      t.integer :subject_id
      t.integer :user_id

      t.timestamps
    end
    add_index :qbanks, :md5_question, unique: true
    add_index :qbanks, :category_id
    add_index :qbanks, :user_id
    add_index :qbanks, :subject_id
  end
end
