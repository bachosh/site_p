class AddCol2ToFiltercoparts < ActiveRecord::Migration[5.1]
  def change
    add_column :filtercoparts, :sale_date, :string
  end
end