class AddColToFilterlinks < ActiveRecord::Migration[5.1]
  def change
   add_column :filtercoparts, :color, :string
  end
end
