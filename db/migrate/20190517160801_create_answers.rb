class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :q_option
      t.integer :user_id
      t.float :q_score
      t.integer :result_id
      t.integer :qbank_id

      t.timestamps
    end
    add_index :answers, :qbank_id
    add_index :answers, :user_id
    add_index :answers, :result_id
  end
end
