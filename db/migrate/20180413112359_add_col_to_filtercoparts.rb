class AddColToFiltercoparts < ActiveRecord::Migration[5.1]
  def change
    add_column :filtercoparts, :to_year, :integer
  end
end
