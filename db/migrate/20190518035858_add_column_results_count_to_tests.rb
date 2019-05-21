class AddColumnResultsCountToTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :results_count, :integer, default: 0
  end
end
