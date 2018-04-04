class CreateFilterlink < ActiveRecord::Migration[5.1]
  def change
    create_table :filterlinks do |t|
      t.string :csv_header_name
      t.string :column_name
      t.string :comments    	

    end
  end
end
