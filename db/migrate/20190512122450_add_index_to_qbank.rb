class AddIndexToQbank < ActiveRecord::Migration[5.2]
  def change
  	add_index :qbanks, :question, name: 'question', type: :fulltext
  end
end
