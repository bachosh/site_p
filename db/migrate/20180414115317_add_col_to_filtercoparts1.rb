class AddColToFiltercoparts1 < ActiveRecord::Migration[5.1]
  def change
    add_column :filtercoparts, :to_odometer, :integer
  end
end
