class AddColumnBannedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :banned, :boolean, default: 0
  end
end
