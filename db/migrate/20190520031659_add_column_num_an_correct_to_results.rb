class AddColumnNumAnCorrectToResults < ActiveRecord::Migration[5.2]
  def change
    add_column :results, :num_an_correct, :integer, default: 0
  end
end
