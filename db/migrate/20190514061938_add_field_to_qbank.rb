class AddFieldToQbank < ActiveRecord::Migration[5.2]
  def change
    add_column :qbanks, :hide_option, :boolean, default: 0
  end
end
