class AddColumnNoqToResults < ActiveRecord::Migration[5.2]
  def change
    add_column :results, :noq, :integer, default: 0
  end
end
