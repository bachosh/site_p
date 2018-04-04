class AddColToFilterlink < ActiveRecord::Migration[5.1]
  def change
  	 add_column :filterlinks, :csv_header_numb, :integer
  end
end
